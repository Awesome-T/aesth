import 'scale.dart';

class LinearScale extends Scale<num> {
  LinearScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    ScaleRange range,
    String alias,
    List<String> ticks,
    int tickCount,

    this.nice,
    this.min,
    this.max,
    this.tickInterval,
  }) : super(
    field: field,
    fieldList: fieldList,
    formatter: formatter,
    range: range,
    alias: alias,
    ticks: ticks,
    tickCount: tickCount,
  );

  final bool nice;

  final num min;

  final num max;

  final num tickInterval;
}
