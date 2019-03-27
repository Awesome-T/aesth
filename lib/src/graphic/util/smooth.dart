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
  final cps = [];

  var prevPoint;
  var nextPoint;
  final hasConstraint = (constraint != null);
  var min;
  var max;
  var point;
  var len;
  var l;
  var i;
  if (hasConstraint) {
    min = [ double.infinity, double.infinity ];
    max = [ double.negativeInfinity, double.negativeInfinity ];

    for (final point in points) {
      final vector =Vector2.fromPoint(point);
      Vector2.min(min, vector, min);
      Vector2.max(max, vector, max);
    }
    Vector2.min(min, Vector2.fromPoint(constraint.topLeft), min);
    Vector2.max(max, Vector2.fromPoint(constraint.bottomRight), min);
  }

}
