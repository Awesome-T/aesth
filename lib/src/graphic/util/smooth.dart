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
  Vector2 min;
  Vector2 max;
  Vector2 vector;
  if (hasConstraint) {
    min = Vector2(double.infinity, double.infinity);
    max = Vector2(double.negativeInfinity, double.negativeInfinity);

    for (final point in points) {
      vector = Vector2.fromPoint(point);
      Vector2.min(min, vector, min);
      Vector2.max(max, vector, max);
    }
    Vector2.min(min, Vector2.fromPoint(constraint.topLeft), min);
    Vector2.max(max, Vector2.fromPoint(constraint.bottomRight), min);
  }

  final len = points.length;
  for (var i = 0; i < len; i++) {
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

List<SmoothDest> _catmullRom2bezier(
  List<math.Point> pointList,
  bool z,
  [math.Rectangle constraint,]
) {
  final isLoop = z;

  final controlPointList = _smoothBezier(pointList, 0.4, isLoop, constraint);
  final len = pointList.length;
  final d1 = <SmoothDest>[];

  math.Point cp1;
  math.Point cp2;
  math.Point p;

  for (var i = 0; i < len; i++) {
    cp1 = controlPointList[i * 2];
    cp2 = controlPointList[i * 2 + 1];
    p = pointList[i + 1];
    d1.add(SmoothDest(cp1, cp2, p));
  }

  if (isLoop) {
    cp1 = controlPointList[len];
    cp2 = controlPointList[len + 1];
    p = pointList[0];
    d1.add(SmoothDest(cp1, cp2, p));
  }
  return d1;
}

final smooth = _catmullRom2bezier;
