import 'dart:ui' show Path, Offset, Rect;

import '../util/smooth.dart' as smoothUtil;
import '../shape.dart' show Shape;

List<Offset> _filterPoints(List<Offset> points) {
  final filteredPoints = <Offset>[];
  for (var point in points) {
    if (
      point.dx != null && point.dx.isFinite &&
      point.dy != null && point.dy.isFinite
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

  List<Offset> points;
  bool smooth = false;

  @override
  void createPath() {
    final filteredPoints = _filterPoints(this.points);

    this.path = Path();
    if (filteredPoints.length > 0) {
      path.moveTo(filteredPoints[0].dx, filteredPoints[0].dy);
      if (this.smooth) {
        final constraint = Rect.fromLTWH(0, 0, 1, 1);
        final sps = smoothUtil.smooth(filteredPoints, false, constraint);
        for (var sp in sps) {
          path.cubicTo(sp.cp1.dx, sp.cp1.dy, sp.cp2.dx, sp.cp2.dy, sp.p.dx, sp.p.dy);
        }
      } else {
        final l = filteredPoints.length - 1;
        for (var i = 1; i < l; i++) {
          path.lineTo(filteredPoints[i].dx, filteredPoints[i].dy);
        }
        path.lineTo(filteredPoints[l].dx, filteredPoints[l].dy);
      }
    }
  }
}
