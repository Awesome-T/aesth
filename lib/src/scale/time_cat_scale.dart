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
    final values = this.values;
    final valuesStamp = values.map(this._toTimeStamp).toList();
    if (this.sortable) {
      valuesStamp.sort();
    }

    if (this.ticks == null) {
      this.ticks = this.calculateTicks();
    }
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

  @override
  double scale(String value) {
    final rangeMin = this.rangeMin();
    final rangeMax = this.rangeMax();
    final index = this.translate(value);

    var percent;
    if (this.values.length == 1 || index == null) { // is index is NAN should not be set as 0
      percent = index;
    } else if (index > -1) {
      percent = index / (this.values.length - 1);
    } else {
      percent = 0;
    }

    return rangeMin + percent * (rangeMax - rangeMin);
  }

  @override
  String getText(String value) {
    var result = '';
    final index = this.translate(value);
    if (index > -1) {
      result = this.values[index];
    } else {
      result = value;
    }

    final formatter = this.formatter;
    if (formatter != null) {
      result = formatter(result);
    }
    return result;
  }

  @override
  List<TickObj<String>> getTicks() {
    final ticks = this.ticks;
    final rst = <TickObj<String>>[];
    ticks?.forEach((tick) {
      final obj = TickObj<String>(
        this.getText(tick),
        tick,
        this.scale(tick),
      );
      rst.add(obj);
    });
    return rst;
  }

  int _toTimeStamp(String value) =>
    this._dateFormat.parse(value).millisecondsSinceEpoch;
}
