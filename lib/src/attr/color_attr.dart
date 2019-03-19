import 'dart:ui';

import 'attr.dart';

class ColorAttr<F> extends Attr<F, Color> {
  ColorAttr({
    String field,
    List<String> fieldList,
    List<Color> valueList,
    Color value,
    AttrValueGenerator<F, Color> valueFunc,

    this.gradient,
  }) : super(
    field: field,
    fieldList: fieldList,
    valueList: valueList,
    value: value,
    valueFunc: valueFunc,
  );

  final Gradient gradient;
}