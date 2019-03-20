import 'dart:ui';

import 'package:aesth/src/base.dart';
import 'package:aesth/src/util/modes.dart';

import 'legend_item.dart';

enum LegendPosition {
  top,
  right,
  bottom,
  left,
}

typedef LegendItemFormatter = String Function(String text);

typedef LegendClickCallback = void Function(Object event);

abstract class Legend extends FieldAttachable {
  Legend({
    String field,
    List<String> fieldList,

    this.position,
    this.align,
    this.itemWidth,
    this.showTitle,
    this.titleStyle,
    this.offset,
    this.titleGap,
    this.itemGap,
    this.itemMarginBottom,
    this.wordSpace,
    this.unCheckColor,
    this.itemFormatter,
    this.marker,
    this.nameStyle,
    this.valueStyle,
    this.joinString,
    this.triggerOn,
    this.triggerOnList,
    this.selectedMode,
    this.clickable,
    this.onClick,
    this.custom,
    this.items
  }) : super(
    field: field,
    fieldList: fieldList,
  );

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

  // TODO
  final Object marker;

  final TextStyle nameStyle;

  final TextStyle valueStyle;

  final String joinString;

  final GestureMode triggerOn;

  final List<GestureMode> triggerOnList;

  final SelectedMode selectedMode;

  final bool clickable;

  final LegendClickCallback onClick;

  final bool custom;

  final List<LegendItem> items;
}