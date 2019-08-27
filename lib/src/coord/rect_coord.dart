import 'dart:ui' show Offset, Rect;

import './coord.dart';

class RectCoord extends Coord {
  RectCoord({
    Rect plot,
    Offset start,
    Offset end,
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
  void init(Offset start, Offset end) {
    this.x = Band(start.dx, end.dx);
    this.y = Band(start.dy, end.dy);
  }

  @override
  Offset convertPoint(Offset point) {
    final transposed = this.transposed;
    final xDim = transposed ? (Offset p) => p.dy : (Offset p) => p.dx;
    final yDim = transposed ? (Offset p) => p.dx : (Offset p) => p.dy;
    final x = this.x;
    final y = this.y;
    return Offset(
      x.start + (x.end - x.start) * xDim(point),
      y.start + (y.end - y.start) * yDim(point),
    );
  }

  @override
  Offset invertPoint(Offset point) {
    final transposed = this.transposed;
    final x = this.x;
    final y = this.y;
    return transposed
      ? Offset(
        (point.dy - y.start) / (y.end - y.start),
        (point.dx - x.start) / (x.end - x.start),
      )
      : Offset(
        (point.dx - x.start) / (x.end - x.start),
        (point.dy - y.start) / (y.end - y.start),
      );
  }
}
