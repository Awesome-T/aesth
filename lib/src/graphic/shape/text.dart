import 'dart:ui' show Canvas, Offset;

import 'package:flutter/painting.dart' show TextSpan, TextPainter, TextAlign, TextWidthBasis;

import '../util/bbox.dart';
import '../shape.dart' show Shape;

class Text extends Shape {
  Text({
    this.x,
    this.y,
    this.text,
    this.textAlign,
    this.maxLines,
    this.ellipsis,
    this.textWidthBasis,
  });

  final type = 'text';

  num x;
  num y;
  TextSpan text;
  TextAlign textAlign = TextAlign.start;
  int maxLines;
  String ellipsis;
  TextWidthBasis textWidthBasis = TextWidthBasis.parent;

  @override
  void createPath() {
  }

  @override
  void drawInner(Canvas canvas) {
    final painter = TextPainter(
      text: this.text,
      textAlign: this.textAlign,
      maxLines: this.maxLines,
      ellipsis: this.ellipsis,
      textWidthBasis: this.textWidthBasis,
    );
    painter.paint(canvas, Offset(this.x, this.y));
  }

  @override
  BBox calculateBox() {
    // TODO: implement calculateBox
    return null;
  }
}
