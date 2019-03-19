import 'dart:ui';

import 'package:aesth/src/base.dart';
import 'package:aesth/src/util/measures.dart';

enum LegendPosition {
  top,
  right,
  bottom,
  left,
}

typedef LegendItemFormatter = String Function(String text);

abstract class Legend extends FieldAttachable {
  final bool show;

  final LegendPosition position;

  final AlignMode align;

  final num itemWidth;

  final bool showTitle;

  final TextStyle titleStyle;

  final Offset offset;

  final num titleGap;

  final num itemGap;

  final num itemMarginBottom;

  final num wordSpace;

  final Color unCheckColor;

  final LegendItemFormatter itemFormatter;
}