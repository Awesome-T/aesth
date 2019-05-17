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

    Gradient gradient,
  }) : super(
    field: field,
    fieldList: fieldList,
    values: values,
    value: value,
    callback: callback,
    scales: scales,
    gradient: gradient,
  );
}