import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/util/measures.dart';

import 'attr.dart';

class SizeAttr extends Attr<num> {
  SizeAttr({
    String field,
    List<num> values,
    num value,
    AttrCallback callback,
    List<Scale> scales,

    this.range,
  }) : super(
    field: field,
    fieldList: null,
    values: values,
    value: value,
    callback: callback,
    scales: scales,
  );

  final names = ['size'];

  final type = 'size';

  final Range range;
}