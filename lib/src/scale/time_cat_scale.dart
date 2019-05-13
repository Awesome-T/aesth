import 'package:aesth/src/util/measures.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'scale.dart';
import 'cat_scale.dart';
import './auto/cat.dart' show catAuto;

/// F could only be formatted String or timestamp int
class TimeCatScale<F> extends CatScale<F> {
  TimeCatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    Range range,
    String alias,
    List<F> ticks,
    int tickCount = 5,
    List<F> values,
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
    if (this.sortable) {
      values.sort((v1, v2) => _toTimeStamp(v1) - _toTimeStamp(v2));
    }

    if (this.ticks == null) {
      this.ticks = this.calculateTicks();
    }
  }

  List<F> calculateTicks() {
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
  num translate(Object value) {
    num index = this.values.indexOf(value);

    if (index == -1) {
      if (value is num && value < this.values.length) {
        index = value;
      } else {
        index = double.nan;
      }
    }
    return index;
  }

  @override
  double scale(Object value) {
    final rangeMin = this.rangeMin();
    final rangeMax = this.rangeMax();
    final index = this.translate(value);

    var percent;
    if (this.values.length == 1 || index.isNaN) { // is index is NAN should not be set as 0
      percent = index;
    } else if (index > -1) {
      percent = index / (this.values.length - 1);
    } else {
      percent = 0;
    }

    return rangeMin + percent * (rangeMax - rangeMin);
  }

  @override
  String getText(Object value) {
    F result;
    final index = this.translate(value);
    if (index > -1) {
      result = this.values[index];
    } else {
      result = value;
    }

    String resultStr = '';
    final formatter = this.formatter;
    if (formatter != null) {
      resultStr = formatter(result);
    }
    return resultStr;
  }

  @override
  List<TickObj<F>> getTicks() {
    final ticks = this.ticks;
    final rst = <TickObj<F>>[];
    ticks?.forEach((tick) {
      final obj = TickObj<F>(
        this.getText(tick),
        tick,
        this.scale(tick),
      );
      rst.add(obj);
    });
    return rst;
  }

  int _toTimeStamp(Object value) =>
    (value is String) ? this._dateFormat.parse(value).millisecondsSinceEpoch : value;
}
