import 'package:aesth/src/util/range.dart';

import 'attr.dart';

class SizeAttr<F> extends Attr<F, num> {
  SizeAttr({
    String field,
    List<num> valueList,
    num value,
    AttrValueGenerator<F, num> valueFunc,

    this.range,
  }) : super(
    field: field,
    fieldList: null,
    valueList: valueList,
    value: value,
    valueFunc: valueFunc,
  );

  final Range range;
}