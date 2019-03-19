import 'dart:ui';

import 'guide.dart';

abstract class TextGuide extends Guide {
  TextGuide({
    bool top,

    this.position,
    this.positionFunc,
    this.content,
    this.style,
    this.offset,
  }) : super(
    top: top,
  );

  final GuideAnchor position;
  final GuideAnchorGenerator positionFunc;

  final String content;

  final TextStyle style;

  final Offset offset;
}
