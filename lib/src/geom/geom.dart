import 'dart:ui';

import 'package:aesth/src/attr/position_attr.dart';
import 'package:aesth/src/attr/color_attr.dart';
import 'package:aesth/src/attr/shape_attr.dart';
import 'package:aesth/src/attr/size_attr.dart';

import 'adjust/adjust.dart';

typedef GeomStyleGenerator<D> = Paint Function(D datum);

abstract class Geom {
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
  });

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
}