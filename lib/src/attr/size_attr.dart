import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/util/measures.dart';

import 'attr.dart';

class SizeAttr<F> extends Attr<F, num> {
  SizeAttr({
    String field,
    List<num> valueList,
    num value,
    AttrCallback<F, num> callback,
    List<Scale<F>> scales,

    this.range,
  }) : super(
    field: field,
    fieldList: null,
    valueList: valueList,
    value: value,
    callback: callback,
    scales: scales,
  );

  final Range range;
}