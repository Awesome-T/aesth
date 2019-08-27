import 'dart:ui' show Canvas, Offset, Rect;

import 'package:flutter/painting.dart' show TextSpan, TextPainter, TextAlign, TextWidthBasis;

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

  TextPainter painter;

  @override
  void createPath() {
    this.painter = TextPainter(
      text: this.text,
      textAlign: this.textAlign,
      maxLines: this.maxLines,
      ellipsis: this.ellipsis,
      textWidthBasis: this.textWidthBasis,
    );
  }

  @override
  void drawInner(Canvas canvas) {
    this.createPath();
    this.painter.paint(canvas, Offset(this.x, this.y));
  }

  @override
  Rect getBBox() => Rect.fromLTWH(this.x, this.y, this.painter.width, this.painter.height);
}
