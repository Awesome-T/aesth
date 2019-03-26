import 'dart:math' as math;

import 'vector2.dart' show Vector2;
import 'smooth.dart' show SmoothPath;

final _start = Vector2.create();
final _end = Vector2.create();
final _extremity = Vector2.create();

math.Point _cubicN(num t, math.Point a, math.Point b, math.Point c, math.Point d) {
  final t2 = t * t;
  final t3 = t2 * t;
  return a 
    + (a * -3 + (a * 3 - a * t) * t) * t
    + (b * 3 + (b * -6 + b * 3 * t) * t) * t
    + (c * 3 - c * 3 * t) * t2 + d * t3;
}

math.Point _getCubicBezierXYatT(
  math.Point startPt,
  math.Point controlPt1,
  math.Point controlPt2,
  math.Point endPt,
  num t,
) => _cubicN(t, startPt, controlPt1, controlPt2, endPt);

BBox _cubicBezierBounds(SmoothPath c) {
  var minX = double.infinity;
  var maxX = double.negativeInfinity;
  var minY = double.infinity;
  var maxY = double.negativeInfinity;
  final s = c.p0;
  final c1 = c.cp1;
  final c2 = c.cp2;
  final e = c.p;
  for (var t = 0; t < 100; t++) {
    final pt =_getCubicBezierXYatT(s, c1, c2, e, t / 100);
    if (pt.x < minX) {
      minX = pt.x;
    }
    if (pt.x > maxX) {
      maxX = pt.x;
    }
    if (pt.y < minY) {
      minY = pt.y;
    }
    if (pt.y > maxY) {
      maxY = pt.y;
    }
  }
  return BBox(
    minX,
    minY,
    maxX,
    maxY,
  );
}

class BBox {
  BBox(this.minX, this.minY, this.maxX, this.maxY);

  factory BBox.fromPoints(List<math.Point> points, [num lineWidth = 0]) {
    if (points.length == 0) {
      return null;
    }
    var p = points[0];
    var left = p.x;
    var right = p.x;
    var top = p.y;
    var bottom = p.y;

    for (p in points) {
      left = math.min(left, p.x);
      right = math.max(right, p.x);
      top = math.min(top, p.y);
      bottom = math.max(bottom, p.y);
    }

    final lineWidth_ = lineWidth / 2;
    
    return BBox(
      left - lineWidth_,
      top - lineWidth_,
      right + lineWidth_,
      bottom + lineWidth_,
    );
  }

  factory BBox.fromLine(num x0, num y0, num x1, num y1, [num lineWidth = 0]) {
    final lineWidth_ = lineWidth / 2;
    
    return BBox(
      math.min(x0, x1) - lineWidth_,
      math.min(y0, y1) - lineWidth_,
      math.max(x0, x1) + lineWidth_,
      math.max(y0, y1) + lineWidth_,
    );
  }

  factory BBox.fromArc(num x, num y, num r, num startAngle, num endAngle, bool anticlockwise) {
    final diff = (startAngle - endAngle).abs();

    if (diff % (math.pi * 2) < 1e-4 && diff > 1e-4) {
      // Is a circle
      return BBox(
        x - r,
        y - r,
        x + r,
        y + r,
      );
    }

    _start[0] = math.cos(startAngle) * r + x;
    _start[1] = math.sin(startAngle) * r + y;

    _end[0] = math.cos(endAngle) * r + x;
    _end[1] = math.sin(endAngle) * r + y;
    final min = Vector2.create();
    final max = Vector2.create();

    Vector2.min(_start, _end, min);
    Vector2.max(_start, _end, max);

    // Thresh to [0, Math.PI * 2]
    startAngle = startAngle % (math.pi * 2);
    if (startAngle < 0) {
      startAngle = startAngle + math.pi * 2;
    }
    endAngle = endAngle % (math.pi * 2);
    if (endAngle < 0) {
      endAngle = endAngle + math.pi * 2;
    }

    if (startAngle > endAngle && !anticlockwise) {
      endAngle += math.pi * 2;
    } else if (startAngle < endAngle && anticlockwise) {
      startAngle += math.pi * 2;
    }
    if (anticlockwise) {
      final tmp = endAngle;
      endAngle = startAngle;
      startAngle = tmp;
    }

    for (var angle = 0.0; angle < endAngle; angle += math.pi / 2.0) {
      if (angle > startAngle) {
        _extremity[0] = math.cos(angle) * r + x;
        _extremity[1] = math.sin(angle) * r + y;

        Vector2.min(min, _extremity, min);
        Vector2.max(max, _extremity, max);
      }
    }

    return BBox(
      min[0],
      min[1],
      max[0],
      max[1],
    );
  }

  factory BBox.getBBoxFromBezierGroup(List<SmoothPath> points, [num lineWidth = 0]) {
    var minX = double.infinity;
    var maxX = double.negativeInfinity;
    var minY = double.infinity;
    var maxY = double.negativeInfinity;
    for (final point in points) {
      final bbox = _cubicBezierBounds(point);
      if (bbox.minX < minX) {
        minX = bbox.minX;
      }
      if (bbox.maxX > maxX) {
        maxX = bbox.maxX;
      }
      if (bbox.minY < minY) {
        minY = bbox.minY;
      }
      if (bbox.maxY > maxY) {
        maxY = bbox.maxY;
      }
    }

    final lineWidth_ = lineWidth / 2;

    return BBox(
      minX - lineWidth_,
      minY - lineWidth_,
      maxX + lineWidth_,
      maxY + lineWidth_,
    );
  }

  final num minX;
  final num minY;
  final num maxX;
  final num maxY;
}