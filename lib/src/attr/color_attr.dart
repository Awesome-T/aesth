import 'dart:ui';

import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

class ColorAttr extends Attr<Color> {
  ColorAttr({
    String field,
    List<String> fieldList,
    List<Color> values,
    Color value,
    AttrCallback callback,
    List<Scale> scales,

    AttrGradient<Color> gradient,
    bool linear = false,
    this.stops,
  }) : super(
    field: field,
    fieldList: fieldList,
    values: values,
    value: value,
    callback: callback,
    scales: scales,
    gradient: gradient,
    linear: linear,
  );

  final names = ['color'];

  final type = 'color';

  List<num> stops;

  Color _defaultGradient(num percent) {
    // only handle no stops, if set stops asume correct
    final values = this.values;
    var stops = this.stops;
    if (stops == null) {
      stops = <double>[];
      for (var i = 0; i < values.length; i++) {
        stops.add(i * (1 / (values.length - 1)));
      }
    }
    for (var s = 0; s < stops.length - 1; s++) {
      final leftStop = stops[s], rightStop = stops[s + 1];
      final leftColor = values[s], rightColor = values[s + 1];
      if (percent <= leftStop) {
        return leftColor;
      } else if (percent < rightStop) {
        final sectionT = (percent - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT);
      }
    }
    return values.last;
  }

  @override
  Color getLinearValue(num percent) {
    if (this.gradient == null) {
      this.gradient = this._defaultGradient;
    }
    return this.gradient(percent);
  }
}