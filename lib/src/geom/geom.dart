import 'dart:ui';

import 'package:aesth/src/attr/position_attr.dart';
import 'package:aesth/src/attr/color_attr.dart';
import 'package:aesth/src/attr/shape_attr.dart';
import 'package:aesth/src/attr/size_attr.dart';
import 'package:aesth/src/coord/coord.dart';
import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/util/tool.dart' show FieldAttachable;

import 'adjust/adjust.dart';
import '../base.dart' show Base;

typedef GeomStyleGenerator<D> = Paint Function(D datum);

class AttributeOption extends FieldAttachable {
  AttributeOption({
    String field,
    List<String> fieldList,
    this.callback,
    this.values,
    this.coord,
  }) : super(field: field, fieldList: fieldList);

  Function callback;
  List values;
  Coord coord;
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

  void _initAttrs() {
    final attrs = this.get('attrs');
    final attrOptions = this.get('attrOptions') as Map<String, AttributeOption>;
    final coord = this.get('coord') as Coord;

    for (final type in attrOptions.keys) {
      final option = attrOptions[type];
      final fields = option.fields;
      if (type == 'position') {
        option.coord = coord;
      }
      const scales = <Scale>[];
      for (var i = 0, len = fields.length; i < len; i++) {
        final field = fields[i];
        final scale = this._createScale(field);
        scales.add(scale);
      }
    }
  }

  
}
