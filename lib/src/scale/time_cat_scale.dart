import 'package:aesth/src/util/measures.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'scale.dart';
import 'cat_scale.dart';
import './auto/cat.dart' show catAuto;

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
    String mask = 'YYYY-MM-DD',
  }) 
    : _dateFormat = DateFormat(mask),
      super(
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

  String get mask => _dateFormat.pattern;

  set mask(String value) => _dateFormat = DateFormat(value);

  DateFormat _dateFormat;

  @override
  void init() {
    
  }

  List<String> calculateTicks() {
    final count = this.tickCount;
    var ticks;
    if (count != null) {
      final temp = catAuto(
        maxCount: count,
        data: this.values,
        isRounding: this.isRouding,
      );
      ticks = temp.ticks;
    } else {
      ticks = this.values;
    }

    return ticks;
  }

  @override
  num translate(String value) {
    var index = this.values.indexOf(value);
    if (index == -1) {
      index = null;
    }
    return index;
  }

  int _toTimeStamp(String value) =>
    this._dateFormat.parse(value).millisecondsSinceEpoch;
}
