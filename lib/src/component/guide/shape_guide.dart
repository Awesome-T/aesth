import 'dart:ui';

import 'guide.dart';

abstract class ShapeGuide extends Guide {
  ShapeGuide({
    bool top,

    this.start,
    this.startFunc,
    this.end,
    this.endFunc,
    this.style,
  }) : super(
    top: top,
  );

  final GuideAnchor start;
  final GuideAnchorGenerator startFunc;

  final GuideAnchor end;
  final GuideAnchorGenerator endFunc;

  final Paint style;
}
