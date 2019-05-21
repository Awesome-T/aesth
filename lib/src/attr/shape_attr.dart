import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

class ShapeAttr extends Attr<String> {
  ShapeAttr({
    String field,
    List<String> fieldList,
    List<String> values,
    String value,
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

  final names = ['shape'];

  final type = 'shape';

  @override
  String getLinearValue(num percent) {
    final values = this.values;
    final index = ((values.length - 1) * percent).round();
    return values[index];
  }
}