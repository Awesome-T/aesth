import 'dart:math' as math;

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
  const hasConstraint = !!constraint;
  var min;
  var max;
  let point;
  let len;
  let l;
  let i;
}
