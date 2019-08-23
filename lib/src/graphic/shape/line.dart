import 'dart:ui' show Path;

import 'package:aesth/src/graphic/util/bbox.dart';

import '../shape.dart' show Shape;

class Line extends Shape {
  Line({
    this.x1,
    this.y1,
    this.x2,
    this.y2,
  });

  final type = 'line';

  num x1 = 0;
  num y1 = 0;
  num x2 = 0;
  num y2 = 0;

  @override
  void createPath() {
    this.path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
  }

  @override
  BBox calculateBox() => BBox.fromLine(x1, y1, x2, y2, this.paint.strokeWidth);
}
