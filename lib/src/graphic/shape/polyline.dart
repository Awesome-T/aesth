import 'dart:ui' show Path;
import 'dart:math' show Point, Rectangle;

import '../util/bbox.dart' show BBox;
import '../util/smooth.dart' as smoothUtil;
import '../shape.dart' show Shape;

List<Point> _filterPoints(List<Point> points) {
  final filteredPoints = <Point>[];
  for (var point in points) {
    if (
      point.x != null && point.x.isFinite &&
      point.y != null && point.y.isFinite
    ) {
      filteredPoints.add(point);
    }
  }
  return filteredPoints;
}

class Polyline extends Shape {
  Polyline({
    this.points,
    this.smooth,
  });

  final type = 'polyline';

  List<Point> points;
  bool smooth = false;

  @override
  void createPath() {
    final filteredPoints = _filterPoints(this.points);

    this.path = Path();
    if (filteredPoints.length > 0) {
      path.moveTo(filteredPoints[0].x, filteredPoints[0].y);
      if (this.smooth) {
        final constraint = Rectangle.fromPoints(Point(0, 0), Point(1, 1));
        final sps = smoothUtil.smooth(filteredPoints, false, constraint);
        for (var sp in sps) {
          path.cubicTo(sp.cp1.x, sp.cp1.y, sp.cp2.x, sp.cp2.y, sp.p.x, sp.p.y);
        }
      } else {
        final l = filteredPoints.length - 1;
        for (var i = 1; i < l; i++) {
          path.lineTo(filteredPoints[i].x, filteredPoints[i].y);
        }
        path.lineTo(filteredPoints[l].x, filteredPoints[l].y);
      }
    }
  }

  @override
  BBox calculateBox() {
    final filteredPoints = _filterPoints(this.points);
    if (this.smooth) {
      final newPaths = <smoothUtil.SmoothPath>[];
      final constraint = Rectangle.fromPoints(Point(0, 0), Point(1, 1));
      final sps = smoothUtil.smooth(filteredPoints, false, constraint);
      for (var i = 0; i < sps.length; i++) {
        final sp = sps[i];
        if (i == 0) {
          newPaths.add(smoothUtil.SmoothPath(
            Point(filteredPoints[0].x, filteredPoints[0].y),
            sp.cp1,
            sp.cp2,
            sp.p,
          ));
        } else {
          final lastSp = sps[i - 1];
          newPaths.add(smoothUtil.SmoothPath(
            lastSp.p,
            sp.cp1,
            sp.cp2,
            sp.p,
          ));
        }
      }
      return BBox.fromBezierGroup(newPaths, this.paint.strokeWidth);
    }
    return BBox.fromPoints(this.points, this.paint.strokeWidth);
  }
}
