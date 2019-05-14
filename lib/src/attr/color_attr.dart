import 'dart:ui';

import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

class ColorAttr<F> extends Attr<F, Color> {
  ColorAttr({
    String field,
    List<String> fieldList,
    List<Color> valueList,
    Color value,
    AttrCallback<F, Color> callback,
    List<Scale<F>> scales,

    this.gradient,
  }) : super(
    field: field,
    fieldList: fieldList,
    valueList: valueList,
    value: value,
    callback: callback,
    scales: scales,
  );

  final Gradient gradient;
}