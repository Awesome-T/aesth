import 'dart:ui';
import 'dart:math' show max;

import 'package:aesth/src/util/tool.dart' show GraphicOperator;
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
      if () {
        
      }
    });
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
              'max': yScale.values.reduce(max),
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
    final data = this.get('data');
    final dataArray = [];
    final groupedArray = this._groupData(data);

  }

  Object getAttr(String name) =>
    this.get('attrs')[name];

  Scale getXScale() =>
    (this.getAttr('position') as PositionAttr)?.scales[0];
  
  Scale getYScale() =>
    (this.getAttr('position') as PositionAttr)?.scales[1];

  bool hasAdjust(String adjust) =>
    (this.get('adjust') as Adjust)?.type == adjust;
}
