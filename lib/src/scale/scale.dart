import 'package:aesth/src/base.dart';
import 'package:aesth/src/util/measures.dart';

typedef ScaleFormatter<F> = String Function(F value);

abstract class Scale<F> extends FieldAttachable {
  Scale({
    String field,
    List<String> fieldList,

    this.formatter,
    this.range,
    this.alias,
    this.ticks,
    this.tickCount,
  }) : super(
    field: field,
    fieldList: fieldList,
  );

  final ScaleFormatter formatter;

  final Range range;

  final String alias;

  final List<String> ticks;
  final int tickCount;
}
