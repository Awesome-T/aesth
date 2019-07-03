import 'dart:math';

class Plot {

  Plot(this.start, this.end) {
    this._init();
  }

  Point start;
  
  Point end;

  Point tl;

  Point tr;

  Point bl;

  Point br;

  num width;

  num height;

  void _init() {
    final xMin = min(start.x, end.x);
    final xMax = max(start.x, end.x);
    final yMin = min(start.y, end.y);
    final yMax = max(start.y, end.y);

    tl = Point(xMin, yMin);
    tr = Point(xMax, yMin);
    bl = Point(xMin, yMax);
    br = Point(xMax, yMax);
    width = xMax - xMin;
    height = yMax - yMin;
  }

  void reset(Point start, Point end) {
    this.start = start;
    this.end = end;
    _init();
  }

  bool isInRange(Point point) {
    final x = point.x;
    final y = point.y;

    return tl.x <= x && x <= br.x && tl.y <= y && y <= br.y;
  }
}