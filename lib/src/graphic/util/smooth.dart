import 'dart:math' as math;

import 'vector2.dart' show Vector2;

class SmoothDest {
  SmoothDest(this.cp1, this.cp2, this.p);

  final math.Point cp1;
  final math.Point cp2;
  // to point
  final math.Point p;
}

class SmoothPath extends SmoothDest {
  SmoothPath(
    this.p0,
    math.Point cp1,
    math.Point cp2,
    math.Point p,
  ) : super(cp1, cp2, p);

  final math.Point p0;
}

List<math.Point> _smoothBezier(
  List<math.Point> points,
  num smooth,
  bool isLoop,
  [math.Rectangle constraint,]
) {
  final cps = <math.Point>[];

  Vector2 prevVector;
  Vector2 nextVector;
  final hasConstraint = (constraint != null);
  var min;
  var max;
  Vector2 vector;
  var len;
  var l;
  var i;
  if (hasConstraint) {
    min = [ double.infinity, double.infinity ];
    max = [ double.negativeInfinity, double.negativeInfinity ];

    for (final point in points) {
      vector = Vector2.fromPoint(point);
      Vector2.min(min, vector, min);
      Vector2.max(max, vector, max);
    }
    Vector2.min(min, Vector2.fromPoint(constraint.topLeft), min);
    Vector2.max(max, Vector2.fromPoint(constraint.bottomRight), min);
  }

  for (var i = 0, len = points.length; i < len; i++) {
    vector = Vector2.fromPoint(points[i]);
    if (isLoop) {
      prevVector = Vector2.fromPoint(points[i > 0 ? i - 1 : len - 1]);
      nextVector = Vector2.fromPoint(points[(i + 1) % len]);
    } else {
      if (i == 0 || i == len -1) {
        cps.add(vector.toPoint());
        continue;
      } else {
        prevVector = Vector2.fromPoint(points[i - 1]);
        nextVector = Vector2.fromPoint(points[i + 1]);
      }
    }

    final v = (nextVector - prevVector) * smooth;
    var d0 = vector.distanceTo(prevVector);
    var d1 = vector.distanceTo(nextVector);

    final sum = d0 + d1;
    if (sum != 0) {
      d0 /= sum;
      d1 /= sum;
    }

    final v1 = v * (-d0);
    final v2 = v * d1;

    final cp0 = vector + v1;
    final cp1 = vector + v2;

    if (hasConstraint) {
      Vector2.max(cp0, min, cp0);
      Vector2.min(cp0, max, cp0);
      Vector2.max(cp1, min, cp1);
      Vector2.min(cp1, max, cp1);
    }

    cps.add(cp0.toPoint());
    cps.add(cp1.toPoint());
  }

  if (isLoop) {
    cps.add(cps.removeAt(0));
  }
  return cps;
}
