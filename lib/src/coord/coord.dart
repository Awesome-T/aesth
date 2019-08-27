import 'dart:ui' show Offset, Rect;

class Band {
  Band(this.start, this.end);

  final num start;
  final num end;
}

abstract class Coord {
  Coord({this.plot, this.start, this.end, this.transposed}) {
    Offset start;
    Offset end;
    if (this.plot != null) {
      start = this.plot.bottomLeft;
      end = this.plot.topRight;
      this.start = start;
      this.end = end;
    } else {
      start = this.start;
      end = this.end;
    }
    this.init(start, end);
  }

  final type = 'base';

  final isRect = false;

  final isPolar = false;

  bool transposed;

  Rect plot;

  Offset start;

  Offset end;

  Band x;

  Band y;

  void init(Offset start, Offset end);

  Offset convertPoint(Offset point);

  Offset invertPoint(Offset point);

  void reset(Rect plot) {
    this.plot = plot;
    this.start = plot.bottomLeft;
    this.end = plot.topRight;
    this.init(plot.bottomLeft, plot.topRight);
  }
}
