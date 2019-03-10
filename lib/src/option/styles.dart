import 'dart:ui';

class TextStyle {
  TextStyle({
    this.color = const Color(0xff333333),
    this.fontStyle = 'normal',
    this.fontWeight = 'normal',
    this.fontFamily = 'sans-serif',
    this.fontSize = 18,
    this.align = 'auto',
    this.verticalAlign = 'auto',
    this.lineHeight,
    this.width,
    this.height,
    this.textBorderColor = const Color(0x00000000),
    this.textBorderWidth = 0,
    this.textShadowColor = const Color(0x00000000),
    this.textShadowBlur = 0,
    this.textShadowOffsetX = 0,
    this.textShadowOffsetY = 0,
    this.rich,
  });

  final Color color;
  final String fontStyle;
  final String fontWeight;
  final String fontFamily;
  final num fontSize;
  final String align;
  final String verticalAlign;
  final num lineHeight;
  final Object width;
  final Object height;
  final Color textBorderColor;
  final num textBorderWidth;
  final Color textShadowColor;
  final num textShadowBlur;
  final num textShadowOffsetX;
  final num textShadowOffsetY;
  final Map<String, TextStyle> rich;
}