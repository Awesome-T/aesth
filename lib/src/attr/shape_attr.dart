import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

enum ShapeMode {
  line,
  dash,
  circle,
  hollowCircle,
}

class ShapeAttr extends Attr<ShapeMode> {
  ShapeAttr({
    String field,
    List<String> fieldList,
    List<ShapeMode> values,
    ShapeMode value,
    AttrCallback callback,
    List<Scale> scales,
  }) : super(
    field: field,
    fieldList: fieldList,
    values: values,
    value: value,
    callback: callback,
    scales: scales,
  );
}