import 'dart:ui' show Path, Offset;

import '../shape.dart' show Shape;

class Polygon extends Shape {
  Polygon({
    this.points,
  });

  final type = 'polygon';

  List<Offset> points;

  @override
  void createPath() {
    final points = this.points;

    this.path = Path();

    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
  }
}
