import 'dart:ui' show Path;
import 'dart:math' show Point;

import 'package:aesth/src/graphic/util/bbox.dart';

import '../shape.dart' show Shape;

class Polygon extends Shape {
  Polygon({
    this.points,
  });

  final type = 'polygon';

  List<Point> points;

  @override
  void createPath() {
    final points = this.points;

    this.path = Path();

    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      if (i == 0) {
        path.moveTo(point.x, point.y);
      } else {
        path.lineTo(point.x, point.y);
      }
    }
    path.close();
  }

  @override
  BBox calculateBox() => BBox.fromPoints(this.points);
}
