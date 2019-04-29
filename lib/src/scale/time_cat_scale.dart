import 'package:aesth/src/util/measures.dart';

import 'scale.dart';
import 'cat_scale.dart';

class TimeCatScale extends CatScale {
  TimeCatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    Range range,
    String alias,
    List<String> ticks,
    int tickCount = 5,
    List<String> values,
    bool isRouding,

    this.sortable = true,
    this.nice,
    this.min,
    this.max,
    this.tickInterval,
    this.mask = 'YYYY-MM-DD',
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

  final type = 'timeCat';

  bool sortable;

  bool nice;

  num min;

  num max;

  num tickInterval;

  String mask;
}
