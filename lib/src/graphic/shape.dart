import 'dart:ui' show Canvas, Path, Rect;

import './element.dart';

abstract class Shape extends Element { 
  final isShape = true;
  final type = null;

  Path path;

  @override
  void drawInner(Canvas canvas) {
    this.createPath();
    canvas.drawPath(this.path, this.paint);
  }

  @override
  Rect getBBox() => this.path.getBounds();

  void createPath();
}
