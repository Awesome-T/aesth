import 'dart:ui';

import 'styles.dart';

class Title {
  Title({
    this.id,
    this.show = true,
    this.text = '',
    this.link = '',
    this.target = 'blank',
    this.textStyle,
    this.subtext = '',
    this.sublink = '',
    this.subtarget = 'blank',
    this.subtextStyle,
    this.textAlign = 'auto',
    this.textVerticalAlign = 'auto',
    this.triggerEvent = false,
    this.padding = 5,
    this.itemGap = 10,
    this.zlevel = 0,
    this.z = 2,
    this.left = 'auto',
    this.top = 'auto',
    this.right = 'auto',
    this.bottom = 'auto',
    this.backgroundColor = const Color(0x00000000),
    this.borderColor = const Color(0x00000000),
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.shadowBlur,
    this.shadowColor,
    this.shadowOffsetX = 0,
    this.shadowOffsetY = 0,
  });

  final String id;
  final bool show;
  final String text;
  final String link;
  final String target;
  final TextStyle textStyle;
  final String subtext;
  final String sublink;
  final String subtarget;
  final TextStyle subtextStyle;
  final String textAlign;
  final String textVerticalAlign;
  final bool triggerEvent;
  // 5 all
  // [5, 10] top bottom 5, right left 10
  // [5, 10, 5, 10] top, right, bottom, left
  final Object padding;
  final num itemGap;
  final num zlevel;
  final num z;
  // 20 | '20%' | 'auto', 'left', 'center', 'right'
  final Object left;
  final Object top;
  final Object right;
  final Object bottom;
  final Color backgroundColor;
  final Color borderColor;
  final num borderWidth;
  // 5 all
  // [5, 5, 0, 0] clockwise start from topleft
  final Object borderRadius;
  final num shadowBlur;
  final Color shadowColor;
  final num shadowOffsetX;
  final num shadowOffsetY;
}