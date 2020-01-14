import 'dart:ui';

import 'package:aesth/src/util/api.dart' show GestureMode;
import 'package:aesth/src/chart/chart.dart';

typedef TooltipCallback<X, Y> = void Function(X x, Y y, String title, List items, Chart chart);

enum CrosshairsType {
  x,
  y,
  xy,
}

class Tip {
  Tip({
    this.val,
    this.style,
  });

  final String val;

  final TextStyle style;
}

typedef TipCreator = Tip Function(String val);

abstract class Tooltip<X, Y> {
  Tooltip({
    this.alwaysShow,
    this.offset,
    this.triggerOn,
    this.triggerOff,
    this.showTitle,
    this.showCrosshairs,
    this.crosshairStyle,
    this.showTooltipMarker,
    this.background,
    this.titleStyle,
    this.nameStyle,
    this.valueStyle,
    this.itemMarkerStyle,
    this.custom,
    this.onShow,
    this.onHide,
    this.onChange,
    this.crosshairsType,
    this.showXTip,
    this.showYTip,
    this.xTip,
    this.xTipFunc,
    this.yTip,
    this.yTipFunc,
    this.xTipBackground,
    this.yTipBackground,
    this.snap,
  });

  final bool alwaysShow;

  final Offset offset;

  final GestureMode triggerOn;

  final GestureMode triggerOff;

  final bool showTitle;

  final bool showCrosshairs;

  final Paint crosshairStyle;

  final bool showTooltipMarker;

  final Paint background;

  final TextStyle titleStyle;

  final TextStyle nameStyle;

  final TextStyle valueStyle;

  // TODO
  final Paint itemMarkerStyle;

  // TODO
  final bool custom;

  final TooltipCallback<X, Y> onShow;

  final TooltipCallback<X, Y> onHide;

  final TooltipCallback<X, Y> onChange;

  final CrosshairsType crosshairsType;

  final bool showXTip;

  final bool showYTip;

  final TextStyle xTip;
  final TipCreator xTipFunc;

  final TextStyle yTip;
  final TipCreator yTipFunc;

  final Paint xTipBackground;

  final Paint yTipBackground;

  final bool snap;
}