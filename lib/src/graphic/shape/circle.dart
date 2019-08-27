import 'dart:ui' show Rect, Offset, Path;

import '../shape.dart' show Shape;

class Circle extends Shape {
  Circle({
    this.x,
    this.y,
    this.r,
  });

  final type = 'circle';

  num x = 0;
  num y = 0;
  num r = 0;

  @override
  void createPath() {
    this.path = Path();
    this.path.addOval(Rect.fromCircle(center: Offset(this.x, this.y), radius: this.r));
  }
}