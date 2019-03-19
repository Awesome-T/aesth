import 'dart:ui';

import 'guide.dart';
import 'shape_guide.dart';

class ArcGuide extends ShapeGuide {
  ArcGuide({
    bool top,
    GuideAnchor start,
    GuideAnchorGenerator startFunc,
    GuideAnchor end,
    GuideAnchorGenerator endFunc,
    Paint style,
  }) : super(
    top: top,
    start: start,
    startFunc: startFunc,
    end: end,
    endFunc: endFunc,
    style: style,
  );
}
