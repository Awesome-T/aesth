import 'dart:math';

import 'package:aesth/src/chart/plot.dart';

import 'coord.dart';

class RectCoord extends Coord {
  RectCoord({
    Plot plot,
    Point start,
    Point end,
    bool transposed = false,
  }) : super(
    plot: plot,
    start: start,
    end: end,
    transposed: transposed,
  );

  final type = 'cartesian';

  final isRect = true;

  @override
  void init(Point<num> start, Point<num> end) {
    this.x = Band(start.x, end.x);
    this.y = Band(start.y, end.y);
  }

  @override
  Point<num> convertPoint(Point<num> point) {
    final transposed = this.transposed;
    final xDim = transposed ? (Point p) => p.y : (Point p) => p.x;
    final yDim = transposed ? (Point p) => p.x : (Point p) => p.y;
    final x = this.x;
    final y = this.y;
    return Point(
      x.start + (x.end - x.start) * xDim(point),
      y.start + (y.end - y.start) * yDim(point),
    );
  }

  @override
  Point<num> invertPoint(Point<num> point) {
    final transposed = this.transposed;
    final x = this.x;
    final y = this.y;
    return transposed
      ? Point(
        (point.y - y.start) / (y.end - y.start),
        (point.x - x.start) / (x.end - x.start),
      )
      : Point(
        (point.x - x.start) / (x.end - x.start),
        (point.y - y.start) / (y.end - y.start),
      );
  }
}
