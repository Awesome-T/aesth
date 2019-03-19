import 'package:aesth/src/base.dart';

typedef AttrValueGenerator<F, V> = V Function(F fieldValue);

abstract class Attr<F, V> extends FieldAttachable {
  Attr({
    String field,
    List<String> fieldList,

    this.valueList,
    this.value,
    this.valueFunc,
  }) : super(
    field: field,
    fieldList: fieldList,
  );

  final List<V> valueList;

  final V value;

  final AttrValueGenerator<F, V> valueFunc;
}