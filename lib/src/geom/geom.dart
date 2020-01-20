import 'dart:ui';
import 'dart:math' as math show max, min;

import 'package:aesth/src/geom/adjust/dodge.dart';
import 'package:aesth/src/geom/adjust/stack.dart';
import 'package:aesth/src/scale/linear_scale.dart';
import 'package:aesth/src/scale/time_cat_scale.dart';
import 'package:aesth/src/util/tool.dart' show GraphicOperator;
import 'package:aesth/src/util/common.dart' show group, mix, merge;
import 'package:aesth/src/attr/attr.dart';
import 'package:aesth/src/attr/position_attr.dart';
import 'package:aesth/src/attr/color_attr.dart';
import 'package:aesth/src/attr/shape_attr.dart';
import 'package:aesth/src/attr/size_attr.dart';
import 'package:aesth/src/coord/coord.dart';
import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/scale/cat_scale.dart';
import 'package:aesth/src/chart/chart.dart' show Chart;

import 'adjust/adjust.dart';
import '../base.dart' show Base;

const GROUP_ATTRS = [ 'color', 'size', 'shape' ];
const FIELD_ORIGIN = '_origin';
const FIELD_ORIGIN_Y = '_originY';

typedef GeomStyleGenerator<D> = Paint Function(D datum);

List<String> parseFields(Object field) {
  if (field is List<String>) {
    return field;
  }
  if (field is String) {
    return field.split(GraphicOperator.cross);
  }
  return null;
}

abstract class Geom extends Base {
  Geom({
    this.generatePoints,
    this.sortable,
    this.startOnZero,
    this.position,
    this.color,
    this.shape,
    this.size,
    this.adjust,
    this.style,
    this.styleFunc,
  }) : super({});

  final bool generatePoints;

  final bool sortable;

  final bool startOnZero;

  final PositionAttr position;

  final ColorAttr color;

  final ShapeAttr shape;

  final SizeAttr size;

  final Adjust adjust;

  final Paint style;
  final GeomStyleGenerator styleFunc;

  @override
  Map<String, Object> getDefaultCfg() => {
    'type': null,
    
    'data': null,
    
    'attrs': <String, Object>{},

    'scales': <String, Object>{},

    'container': null,

    'styleOptions': null,

    'chart': null,

    'shapeType': '',

    'generatePoints': false,

    'attrOptions': <String, Object>{},

    'sortable': false,
    'startOnZero': true,
    'visible': true,
    'connectNulls': false
  };

  void init() {
    this._initAttrs();
  }

  List<Scale> _getGroupScales() {
    final scales = <Scale>[];
    GROUP_ATTRS.forEach((attrName) {
      final attr = this.getAttr(attrName);
      if (attr != null) {
        final attrScales = attr.scales;
        attrScales?.forEach((scale) {
          if (scale != null && scale.isCategory && (!scales.contains(scale))) {
            scales.add(scale);
          }
        });
      }
    });
    return scales;
  }

  List<List<Map<String, Object>>> _groupData(data) {
    final colDefs = this.get('colDefs');
    final groupScales = this._getGroupScales();
    if (groupScales.isNotEmpty) {
      final appendConditions = <String, List<Object>>{};
      final names = <String>[];
      groupScales.forEach((scale) {
        final field = scale.field;
        names.add(field);
        if ((colDefs ?? const {})[field]?.values != null) { // users have defined
          appendConditions[scale.field] = colDefs[field].values;
        }
      });
      return group(data, names, appendConditions);
    }
    return [data];
  }

  void _setAttrOptions(String attrName, Map<String, Object> attrCfg) {
    final Map<String, Map<String, Object>> options = this.get('attrOptions');
    options[attrName] = attrCfg;
  }

  // cfg is Function | List<V>
  void _createAttrOption(String attrName, String field, [Object cfg, List defaultValues]) {
    final attrCfg = <String, Object>{};
    attrCfg['field'] = field;
    if (cfg != null) {
      if (cfg is Function) {
        attrCfg['callback'] = cfg;
      } else {
        attrCfg['values'] = cfg;
      }
      this._setAttrOptions(attrName, attrCfg);
    }
  }

  void _initAttrs() {
    final attrs = this.get('attrs');
    final Map<String, Map<String, Object>> attrOptions = this.get('attrOptions');
    final Coord coord = this.get('coord');

    for (final type in attrOptions.keys) {
      final option = attrOptions[type];
      final fields = parseFields(option['field']);
      if (type == 'position') {
        option['coord'] = coord;
      }
      final scales = <Scale>[];
      for (var i = 0, len = fields.length; i < len; i++) {
        final field = fields[i];
        final scale = this._createScale(field);
        scales.add(scale);
      }
      if (type == 'position') {
        final yScale = scales[1];
        if (coord.type == 'polar' && coord.transposed && this.hasAdjust('stack')) {
          if (yScale is CatScale<num> && yScale.values.isNotEmpty) {
            yScale.change({
              'nice': false,
              'min': 0,
              'max': yScale.values.reduce(math.max),
            });
          }
        }
      }

      option['scales'] = scales;
      final attr = Attr.create(type, option);
      attrs[type] = attr;
    }
  }

  Scale _createScale(String field) {
    final Map<String, Scale> scales = this.get('scales');
    var scale = scales[field];
    if (scale == null) {
      scale = (this.get('chart') as Chart).createScale(field);
      scales[field] = scale;
    }
    return scale;
  }

  List _processData() {
    final List<Map<String, Object>> data = this.get('data');
    final List<List<Map<String, Object>>> dataArray = [];
    final groupedArray = this._groupData(data);
    for (var i = 0, len = groupedArray.length; i < len; i++) {
      final subData = groupedArray[i];
      final tempData = this._saveOrigin(subData);
      if (this.hasAdjust('dodge')) {
        this._numberic(data);
      }
      dataArray.add(tempData);
    }
    return dataArray;
  }

  List<Map<String, Object>> _saveOrigin(List<Map<String, Object>> data) {
    final rst = <Map<String, Object>>[];
    for (var i = 0, len = data.length; i < len; i++) {
      final origin = data[i];
      final obj = <String, Object>{};
      for (var k in origin.keys) {
        obj[k] = origin[k];
      }
      obj[FIELD_ORIGIN] = origin;
      rst.add(obj);
    }
    return rst;
  }

  void _numberic(List<Map<String, Object>> data) {
    final PositionAttr positionAttr = this.getAttr('position');
    final scales = positionAttr.scales;
    for (var j = 0, len = data.length; j < len; j++) {
      final obj = data[j];
      final count = math.min(2, scales.length);
      for (var i = 0; i < count; i++) {
        final scale = scales[i];
        if (scale.isCategory) {
          final field = scale.field;
          obj[field] = scale.translate(obj[field]);
        }
      }
    }
  }

  void _adjustData(List<List<Map<String, Object>>> dataArray) {
    final Adjust adjust = this.get('adjust');
    if (adjust != null) {
      final xScale = this.getXScale();
      final yScale = this.getYScale();
      final cfg = {
        'xField': xScale.field,
        'yField': yScale.field,
      };
      if (adjust is Dodge) {
        mix([cfg, {
          'marginRatio': adjust.marginRatio,
          'dodgeRatio': adjust.dodgeRatio,
        }]);
      }
      if (adjust is Stack) {
        mix([cfg, {
          'reverseOrder': adjust.reverseOrder,
        }]);
      }
      final adjustObject = Adjust.create(adjust.type, cfg);
      adjustObject.processAdjust(dataArray);
      if (adjust.type == 'stack') {
        this._updateStackRange(yScale.field, yScale, dataArray);
      }
    }
  }

  void _updateStackRange(String field, LinearScale scale, List<List<Map<String, Object>>> dataArray) {
    final mergeArray = merge(dataArray);
    var min = scale.min;
    var max = scale.max;
    for (var i = 0, len = mergeArray.length; i < len; i++) {
      final obj = mergeArray[i];
      final tmpMin = (obj[field] as List<num>).reduce(math.min);
      final tmpMax = (obj[field] as List<num>).reduce(math.max);
      if (tmpMin < min) {
        min = tmpMin;
      }
      if (tmpMax > max) {
        max = tmpMax;
      }
    }
    if (min < scale.min || max > scale.max) {
      scale.change({
        'min': min,
        'max': max,
      });
    }
  }

  void _sort(List<List<Map<String, Object>>> mappedArray) {
    final xScale = this.getXScale();
    final field = xScale.field;
    if (xScale is CatScale && xScale.values.length > 1) {
      mappedArray?.forEach((itemArr) {
        itemArr?.sort((obj1, obj2) {
          if (xScale is TimeCatScale) {
            return xScale.toTimeStamp((obj1[FIELD_ORIGIN] as Map<String, Object>)[field])
              - xScale.toTimeStamp((obj2[FIELD_ORIGIN] as Map<String, Object>)[field]);
          }
          return xScale.translate((obj1[FIELD_ORIGIN] as Map<String, Object>)[field])
            - xScale.translate((obj2[FIELD_ORIGIN] as Map<String, Object>)[field]);
        });
      });
    }

    this.set('hasSorted', true);
    this.set('dataArray', mappedArray);
  }

  // void paint() {
  //   final List<List<Map<String, Object>>> dataArray = this.get('dataArray');
  //   final mappedArray = <List<Map<String, Object>>>[];
  //   final shapeFactory = this.
  // }

  // getShapeFactory() {
  //   var 
  // }

  Attr getAttr(String name) =>
    this.get('attrs')[name];

  Scale getXScale() =>
    (this.getAttr('position') as PositionAttr)?.scales[0];
  
  Scale getYScale() =>
    (this.getAttr('position') as PositionAttr)?.scales[1];

  bool hasAdjust(String adjust) =>
    (this.get('adjust') as Adjust)?.type == adjust;
}
