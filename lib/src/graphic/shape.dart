import 'dart:ui' show Canvas, Paint;
import './util/matrix.dart' show Matrix, TransAction;

import './element.dart';
import './util/bbox.dart' show BBox;

abstract class Shape extends Element {
  Shape(
    Paint paint,
    num width,
    num height,
    int zIndex,
    bool visible,
    bool destroyed,
    Element parent,
    List<Element> children,
    BBox bbox,
    Matrix matrix,
    double x,
    double y,
  ) : super (
    paint: paint,
    width: width,
    height: height,
    zIndex: zIndex,
    visible: visible,
    destroyed: destroyed,
    parent: parent,
    children: children,
    bbox: bbox,
    matrix: matrix,
    x: x,
    y: y,
  );

  final isShape = true;

  final type = null;

  @override
  void drawInner(Canvas canvas) {
    this.createPath(canvas);
    final originOpacity = 
  }

  BBox getBBox() {

  }

  BBox calculateBox();

  void createPath(Canvas canvas);
}
