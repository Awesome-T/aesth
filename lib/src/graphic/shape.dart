import 'dart:ui' show Canvas, Path;

import './element.dart';
import './util/bbox.dart' show BBox;

abstract class Shape extends Element { 
  final isShape = true;
  final type = null;

  Path path;

  @override
  void drawInner(Canvas canvas) {
    this.createPath();
    canvas.drawPath(this.path, this.paint);
  }

  BBox getBBox() {
    if (this.bbox == null) {
      this.bbox = this.calculateBox();
    }
    return this.bbox;
  }

  BBox calculateBox();

  void createPath();
}
