import 'dart:math';

import 'package:aesth/src/chart/plot.dart';

class Band {
  Band(this.start, this.end);

  final num start;
  final num end;
}

abstract class Coord {
  Coord({this.plot, this.start, this.end, this.transposed}) {
    Point start;
    Point end;
    if (this.plot != null) {
      start = this.plot.bl;
      end = this.plot.tr;
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

  Plot plot;

  Point start;

  Point end;

  Band x;

  Band y;

  void init(Point start, Point end);

  Point convertPoint(Point point);

  Point invertPoint(Point point);

  void reset(Plot plot) {
    this.plot = plot;
    this.start = plot.bl;
    this.end = plot.tr;
    this.init(plot.bl, plot.tr);
  }
}
