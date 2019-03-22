import 'dart:math' as math;

import 'vector2.dart' show Vector2;

final start = Vector2.create();
final end = Vector2.create();
final extremity = Vector2.create();

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

    start[0] = math.cos(startAngle) * r + x;
    start[1] = math.sin(startAngle) * r + y;

    end[0] = math.cos(endAngle) * r + x;
    end[1] = math.sin(endAngle) * r + y;
    final min = Vector2.create();
    final max = Vector2.create();

    Vector2.min(start, end, min);
    Vector2.max(start, end, max);

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
        extremity[0] = math.cos(angle) * r + x;
        extremity[1] = math.sin(angle) * r + y;

        Vector2.min(min, extremity, min);
        Vector2.max(max, extremity, max);
      }
    }

    return BBox(
      min[0],
      min[1],
      max[0],
      max[1],
    );
  }

  final num minX;
  final num minY;
  final num maxX;
  final num maxY;
}