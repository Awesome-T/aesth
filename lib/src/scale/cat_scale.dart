import 'scale.dart';

class CatScale<F> extends Scale<F> {
  CatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    ScaleRange range,
    String alias,
    List<String> ticks,
    int tickCount,

    this.values,
    this.isRouding,
  }) : super(
    field: field,
    fieldList: fieldList,
    formatter: formatter,
    range: range,
    alias: alias,
    ticks: ticks,
    tickCount: tickCount,
  );

  final List<F> values;

  final bool isRouding;
}
