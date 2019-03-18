import 'scale.dart';
import 'cat_scale.dart';

class TimeCatScale<F> extends CatScale<F> {
  TimeCatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    ScaleRange range,
    String alias,
    List<String> ticks,
    int tickCount,
    List<F> values,
    bool isRouding,

    this.nice,
    this.min,
    this.max,
    this.tickInterval,
    this.mask,
  }) : super(
    field: field,
    fieldList: fieldList,
    formatter: formatter,
    range: range,
    alias: alias,
    ticks: ticks,
    tickCount: tickCount,
    values: values,
    isRouding: isRouding,
  );

  final bool nice;

  final num min;

  final num max;

  final num tickInterval;

  final String mask;
}
