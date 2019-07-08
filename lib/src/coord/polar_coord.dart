import 'dart:math';

import 'package:aesth/src/chart/plot.dart';
import 'package:aesth/src/graphic/util/vector2.dart';
import 'package:aesth/src/graphic/util/matrix.dart';

import 'coord.dart';

class PolarCoord extends Coord {
  PolarCoord({
    Plot plot,
    Point start,
    Point end,
    bool transposed = false,

    this.radius,
    this.innerRadius = 0,
    this.startAngle = -pi / 2,
    this.endAngle = pi * 3 / 2,
  }) : super(
    plot: plot,
    start: start,
    end: end,
    transposed: transposed,
  );

  final type = 'polar';

  final isPolar = true;

  Point center;

  num radius;

  num innerRadius;

  num inner = 0;

  num startAngle;

  num endAngle;

  num circleRadius;

  @override
  void init(Point<num> start, Point<num> end) {
    final inner = (this.inner == 0 || this.inner == null) ? this.innerRadius : this.inner;
    final width = (end.x - start.x).abs();
    final height = (end.y - start.y).abs();

    var maxRadius;
    var center;
    if (this.startAngle == -pi && this.endAngle == 0) {
      maxRadius = min(width / 2, height);
      center = Point(
        (start.x + end.x) / 2,
        start.y,
      );
    } else {
      maxRadius = min(width, height) / 2;
      center = Point(
        (start.x + end.x) / 2,
        (start.y + end.y) / 2,
      );
    }

    final radius = this.radius;
    if (radius != null && radius > 0 && radius <= 1) {
      maxRadius = maxRadius * radius;
    }

    this.x = Band(
      this.startAngle,
      this.endAngle,
    );

    this.y = Band(
      maxRadius * inner,
      maxRadius,
    );

    this.center = center;

    this.circleRadius = maxRadius;
  }

  @override
  Point<num> convertPoint(Point<num> point) {
    final center = this.center;
    final transposed = this.transposed;
    final xDim = transposed ? (Point p) => p.y : (Point p) => p.x;
    final yDim = transposed ? (Point p) => p.x : (Point p) => p.y;
    final x = this.x;
    final y = this.y;

    final angle = x.start + (x.end - x.start) * xDim(point);
    final radius = y.start + (y.end - y.start) * yDim(point);

    return Point(
      center.x + cos(angle) * radius,
      center.y + sin(angle) * radius,
    );
  }

  @override
  Point<num> invertPoint(Point<num> point) {
    final center = this.center;
    final transposed = this.transposed;
    final x = this.x;
    final y = this.y;

    final m = Matrix(1, 0, 0, 1, 0, 0);
    m.rotate(x.start);

    var startV = Vector2(1, 0);
    startV.transformMat2d(m);
    startV = Vector2(startV.x, startV.y);

    final pointV = Vector2(point.x - center.x, point.y - center.y);
    if (pointV.zero()) {
      return Point(0, 0);
    }

    var theta = startV.angleTo(pointV, x.end < x.start);
    if ((theta - pi * 2).abs() < 0.001) {
      theta = 0;
    }
    final l = pointV.length;
    var percentX = theta / (x.end - x.start);
    percentX = x.end - x.start > 0 ? percentX : -percentX;
    final percentY = (l - y.start) / (y.end - y.start);
    return transposed
      ? Point(
        percentY,
        percentX,
      )
      : Point(
        percentX,
        percentY,
      );
  }
}
