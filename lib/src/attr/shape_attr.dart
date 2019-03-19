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
    AttrValueGenerator<F, ShapeMode> valueFunc,
  }) : super(
    field: field,
    fieldList: fieldList,
    valueList: valueList,
    value: value,
    valueFunc: valueFunc,
  );
}