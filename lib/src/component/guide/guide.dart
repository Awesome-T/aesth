import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/util/measures.dart';

enum GuideAnchorMode {
  max,
  min,
  median,
}

class GuideAnchor<X, Y> {
  GuideAnchor({
    this.x,
    this.xPercent,
    this.xMeasure,
    this.y,
    this.yPercent,
    this.yMeasure,
  });

  final X x;
  final num xPercent;
  final GuideAnchorMode xMeasure;

  final Y y;
  final num yPercent;
  final GuideAnchorMode yMeasure;
}

typedef GuideAnchorGenerator<X, Y> = GuideAnchor<X, Y> Function(Scale<X> xScale, List<Scale<Y>> yScales);

abstract class Guide {
  Guide({
    this.top,
  });

  final bool top;
}