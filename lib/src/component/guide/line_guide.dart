import 'dart:ui';

import 'guide.dart';
import 'shape_guide.dart';

class LineGuide extends ShapeGuide {
  LineGuide({
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
