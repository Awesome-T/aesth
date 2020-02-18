import 'dart:ui' show Offset;

import 'shape.dart';
import 'package:aesth/src/graphic/group.dart' show Group;

bool equals(num v1, num v2) =>
  (v1 - v2).abs() < 0.00001;

bool notEmpty(num value) =>
  value != null && !value.isNaN;

List<Offset> filterPoints(List<Offset> points) {
  final filteredPoints = <Offset>[];
  // filter the point which x or y is NaN
  for (var i = 0, len = points.length; i < len; i++) {
    final point = points[i];
    if (notEmpty(point.dx) && notEmpty(point.dy)) {
      filteredPoints.add(point);
    }
  }

  return filteredPoints;
}

bool equalsCenter(List<Offset> points, Offset center) {
  var eqls = true;
  points?.forEach((point) {
    if (!equals(point.dx, center.dx) || !equals(point.dy, center.dy)) {
      eqls = false;
      return false;
    }
  });
  return eqls;
}

class Area extends ShapeFactoryBase {
  @override
  ShapeBase getShape(String type) {
    // TODO: implement getShape
    return null;
  }
  
  ShapeBase drawRectShape(List<Offset> topPoints, List<Offset> bottomPoints, Group container, )
}
