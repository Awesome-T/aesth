import 'dart:math';
import 'dart:ui' show Offset, Rect;

import 'package:aesth/src/graphic/util/vector2.dart';
import 'package:aesth/src/graphic/util/matrix.dart';

import './coord.dart';

class PolarCoord extends Coord {
  PolarCoord({
    Rect plot,
    Offset start,
    Offset end,
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

  Offset center;

  num radius;

  num innerRadius;

  num inner = 0;

  num startAngle;

  num endAngle;

  num circleRadius;

  @override
  void init(Offset start, Offset end) {
    final inner = (this.inner == 0 || this.inner == null) ? this.innerRadius : this.inner;
    final width = (end.dx - start.dx).abs();
    final height = (end.dy - start.dy).abs();

    var maxRadius;
    var center;
    if (this.startAngle == -pi && this.endAngle == 0) {
      maxRadius = min(width / 2, height);
      center = Offset(
        (start.dx + end.dx) / 2,
        start.dy.toDouble(),  // ensure double for Vector2
      );
    } else {
      maxRadius = min(width, height) / 2;
      center = Offset(
        (start.dx + end.dx) / 2,
        (start.dy + end.dy) / 2,
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
  Offset convertPoint(Offset point) {
    final center = this.center;
    final transposed = this.transposed;
    final xDim = transposed ? (Offset p) => p.dy : (Offset p) => p.dx;
    final yDim = transposed ? (Offset p) => p.dx : (Offset p) => p.dy;
    final x = this.x;
    final y = this.y;

    final angle = x.start + (x.end - x.start) * xDim(point);
    final radius = y.start + (y.end - y.start) * yDim(point);

    return Offset(
      center.dx + cos(angle) * radius,
      center.dy + sin(angle) * radius,
    );
  }

  @override
  Offset invertPoint(Offset point) {
    final center = this.center;
    final transposed = this.transposed;
    final x = this.x;
    final y = this.y;

    final m = Matrix(1, 0, 0, 1, 0, 0);
    m.rotate(x.start);

    var startV = Vector2(1, 0);
    startV.transformMat2d(m);
    startV = Vector2(startV.x, startV.y);

    final pointV = Vector2(point.dx - center.dx, point.dy - center.dy);
    if (pointV.zero()) {
      return Offset(0, 0);
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
      ? Offset(
        percentY,
        percentX,
      )
      : Offset(
        percentX,
        percentY,
      );
  }
}
