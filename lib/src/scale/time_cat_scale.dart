import 'package:aesth/src/util/measures.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'scale.dart';
import 'cat_scale.dart';
import './auto/cat.dart' show catAuto;

/// F could only be formatted String or timestamp int
class TimeCatScale<F> extends CatScale<F> {
  TimeCatScale({
    String field,
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
    String mask = 'yyyy-MM-dd',
  }) 
    : _dateFormat = DateFormat(mask),
      super(
        field: field,
        formatter: formatter,
        range: range,
        alias: alias,
        ticks: ticks,
        tickCount: tickCount,
        values: values,
        isRouding: isRouding ?? true,
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

  int _toTimeStamp(Object value) =>
    (value is String) ? this._dateFormat.parse(value).millisecondsSinceEpoch : value;
  
  List<F> calculateTicks() {
    final count = this.tickCount;
    var ticks;
    if (count != null) {
      final temp = catAuto<F>(
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
    int valueStamp = this._toTimeStamp(value);
    num index = this.values.map(_toTimeStamp).toList().indexOf(valueStamp);

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

    final formatter = this.formatter;
    if (formatter != null) {
      return formatter(result);
    }
    if (result is int) {
      return this._dateFormat.format(DateTime.fromMillisecondsSinceEpoch(result));
    }
    if (result is String) {
      return result;
    }
    return '';
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

  @override
  CatScale<F> clone() => TimeCatScale(
    field: this.field,
    formatter: this.formatter,
    range: this.range,
    alias: this.alias,
    ticks: this.ticks,
    tickCount: this.tickCount,
    values: this.values,
    isRouding: this.isRouding,
    sortable:  this.sortable,
    nice: this.nice,
    min: this.min,
    max: this.max,
    tickInterval: this.tickInterval,
    mask: this.mask,
  );
  
  @override
  void changeFields(Map<String, Object> info) {
    if (info.containsKey('field')) {
      this.field = info['field'];
    }
    if (info.containsKey('field')) {
      this.field = info['field'];
    }
    if (info.containsKey('formatter')) {
      this.formatter = info['formatter'];
    }
    if (info.containsKey('range')) {
      this.range = info['range'];
    }
    if (info.containsKey('alias')) {
      this.alias = info['alias'];
    }
    if (info.containsKey('ticks')) {
      this.ticks = info['ticks'];
    }
    if (info.containsKey('tickCount')) {
      this.tickCount = info['tickCount'];
    }
    if (info.containsKey('values')) {
      this.values = info['values'];
    }
    if (info.containsKey('isRouding')) {
      this.isRouding = info['isRouding'];
    }
    if (info.containsKey('sortable')) {
      this.sortable = info['sortable'];
    }
    if (info.containsKey('nice')) {
      this.nice = info['nice'];
    }
    if (info.containsKey('min')) {
      this.min = info['min'];
    }
    if (info.containsKey('max')) {
      this.max = info['max'];
    }
    if (info.containsKey('tickInterval')) {
      this.tickInterval = info['tickInterval'];
    }
    if (info.containsKey('mask')) {
      this.mask = info['mask'];
    }
  }
}
