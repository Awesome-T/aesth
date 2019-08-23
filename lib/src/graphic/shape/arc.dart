import 'dart:ui' show Rect, Offset, Path;
import 'dart:math' show pi;

import 'package:aesth/src/graphic/util/bbox.dart';

import '../shape.dart' show Shape;

class Arc extends Shape {
  Arc({
    this.x,
    this.y,
    this.r,
    this.startAngle,
    this.endAngle,
    this.anticlockwise,
  });

  final type = 'arc';

  num x = 0;
  num y = 0;
  num r = 0;
  num startAngle = 0;
  num endAngle = pi * 2;
  bool anticlockwise = false;

  @override
  void createPath() {
    final sweepAngle = anticlockwise ? startAngle - endAngle : endAngle - startAngle;

    this.path = Path();
    this.path.arcTo(
      Rect.fromCircle(center: Offset(this.x, this.y), radius: this.r),
      startAngle,
      sweepAngle,
      false,
    );
  }

  @override
  BBox calculateBox() => BBox.fromArc(x, y, r, startAngle, endAngle, anticlockwise);
}
