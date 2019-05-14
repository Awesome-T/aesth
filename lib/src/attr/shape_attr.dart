import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

enum ShapeMode {
  line,
  dash,
  circle,
  hollowCircle,
}

class ShapeAttr<F> extends Attr<F, ShapeMode> {
  ShapeAttr({
    String field,
    List<String> fieldList,
    List<ShapeMode> valueList,
    ShapeMode value,
    AttrCallback<F, ShapeMode> callback,
    List<Scale<F>> scales,
  }) : super(
    field: field,
    fieldList: fieldList,
    valueList: valueList,
    value: value,
    callback: callback,
    scales: scales,
  );
}