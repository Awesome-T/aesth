import 'package:aesth/src/util/api.dart' show Range;

import 'scale.dart';
import './auto/number.dart' show numberAuto;

class LinearScale extends Scale<num> {
  LinearScale({
    String field,
    ScaleFormatter formatter,
    Range range,
    String alias,
    List<num> ticks,
    int tickCount,

    this.nice = false,
    this.min,
    this.max,
    this.tickInterval,
  }) : super(
    field: field,
    formatter: formatter,
    range: range ?? Range(0, 1),
    alias: alias,
    ticks: ticks,
    tickCount: tickCount,
  );

  final type = 'linear';
  final isLinear = true;

  bool nice;

  num min;

  num max;

  num tickInterval;

  num minLimit;

  num maxLimit;

  num minTickInterval;

  List<num> snapArray;

  @override
  void init() {
    if (this.ticks == null) {
      this.min = this.translate(this.min);
      this.max = this.translate(this.max);
      this.initTicks();
    } else {
      final ticks = this.ticks;
      final firstValue = this.translate(ticks[0]);
      final lastValue = this.translate(ticks.last);
      if (this.min == null || this.min > firstValue) {
        this.min = firstValue;
      }
      if (this.max == null || this.max < lastValue) {
        this.max = lastValue;
      }
    }
  }

  @override
  num translate(num value) => value;

  List<num> calculateTicks() {
    final min = this.min;
    final max = this.max;
    final minLimit = this.minLimit;
    final maxLimit = this.maxLimit;
    final tickCount = this.tickCount;
    final tickInterval = this.tickInterval;
    final minTickInterval = this.minTickInterval;
    final snapArray = this.snapArray;

    if (tickCount == 1) {
      throw Exception('linear scale\'tickCount should not be 1');
    }
    if (max < min) {
      throw Exception('max: $max should not be less than min: $min');
    }
    final tmp = numberAuto(
      min: min,
      max: max,
      minLimit: minLimit,
      maxLimit: maxLimit,
      minCount: tickCount,
      maxCount: tickCount,
      interval: tickInterval,
      minTickInterval: minTickInterval,
      snapArray: snapArray,
    );
    return tmp.ticks;
  }

  void initTicks() {
    final calTicks = this.calculateTicks();
    if (this.nice) {
      this.ticks = calTicks;
      this.min = calTicks[0];
      this.max = calTicks.last;
    } else {
      final ticks = <num>[];
      calTicks?.forEach((tick) {
        if (tick >= this.min && tick <= this.max) {
          ticks.add(tick);
        }
      });

      if (ticks.isEmpty) {
        ticks.add(this.min);
        ticks.add(this.max);
      }

      this.ticks = ticks;
    }
  }

  @override
  double scale(num value) {
    if (value == null) {
      return double.nan;
    }
    final max = this.max;
    final min = this.min;
    if (max == min) {
      return 0;
    }

    final percent = (value - min) / (max - min);
    final rangeMin = this.rangeMin();
    final rangeMax = this.rangeMax();
    return rangeMin + percent * (rangeMax - rangeMin);
  }

  @override
  double invert(Object value) {
    if (value is num) {
      final percent = (value - this.rangeMin()) / (this.rangeMax() - this.rangeMin());
      return this.min + percent * (this.max - this.min);
    }
    return double.nan;
  }

  @override
  Scale<num> clone() => LinearScale(
    field: this.field,
    formatter: this.formatter,
    range: this.range,
    alias: this.alias,
    ticks: this.ticks,
    tickCount: this.tickCount,
    nice: this.nice,
    min: this.min,
    max: this.max,
    tickInterval: this.tickInterval,
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
  }
}
