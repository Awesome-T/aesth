import 'dart:ui' show Rect, Offset, Path;
import 'dart:math' show pi, sin, cos;

import '../util/bbox.dart';
import '../shape.dart' show Shape;

class Sector extends Shape {
  Sector({
    this.x,
    this.y,
    this.r,
    this.r0,
    this.startAngle,
    this.endAngle,
    this.anticlockwise,
  });

  final type = 'sector';

  num x = 0;
  num y = 0;
  num r = 0;
  num r0 = 0;
  num startAngle = 0;
  num endAngle = pi * 2;
  bool anticlockwise = false;

  @override
  void createPath() {
    final sweepAngle = anticlockwise ? startAngle - endAngle : endAngle - startAngle;

    this.path = Path();

    final unitX = cos(startAngle);
    final unitY = sin(startAngle);
    this.path.moveTo(unitX * r0 + x, unitY * r0 + y);
    this.path.arcTo(
      Rect.fromCircle(center: Offset(this.x, this.y), radius: this.r),
      startAngle,
      sweepAngle,
      false,
    );
    this.path.arcTo(
      Rect.fromCircle(center: Offset(this.x, this.y), radius: this.r0),
      endAngle,
      -sweepAngle,
      false,
    );
  }

  @override
  BBox calculateBox() {
    // TODO: implement calculateBox
    return null;
  }
}
