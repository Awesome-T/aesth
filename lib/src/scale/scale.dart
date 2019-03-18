import 'package:aesth/src/base.dart';

typedef ScaleFormatter<F> = String Function(F value);

class ScaleRange {
  ScaleRange(this.min, this.max);

  final num min;

  final num max;
}

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

  final ScaleRange range;

  final String alias;

  final List<String> ticks;
  final int tickCount;
}
