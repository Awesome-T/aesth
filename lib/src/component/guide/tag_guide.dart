import 'dart:ui';

import 'guide.dart';
import 'text_guide.dart';

enum TagGuideDirect {
  topLeft,
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
}

class TagGuide extends TextGuide {
  TagGuide({
    bool top,
    GuideAnchor position,
    GuideAnchorGenerator positionFunc,
    String content,
    TextStyle style,
    Offset offset,

    this.direct,
    this.size,
    this.background,
    this.withPoint,
    this.pointStyle,
  }) : super(
    top: top,
    position: position,
    positionFunc: positionFunc,
    content: content,
    style: style,
    offset: offset,
  );

  final TagGuideDirect direct;

  final num size;

  final Paint background;

  final bool withPoint;

  final Paint pointStyle;
}
