import 'package:aesth/src/util/measures.dart';

import 'scale.dart';
import './auto/cat.dart' show catAuto;

class CatScale extends Scale<String> {
  CatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    Range range,
    String alias,
    List<String> ticks,
    int tickCount,

    this.values,
    this.isRouding = true,
  }) : super(
    field: field,
    fieldList: fieldList,
    formatter: formatter,
    range: range ?? Range(0, 1),
    alias: alias,
    ticks: ticks,
    tickCount: tickCount,
  );

  final type = 'cat';
  final isCategory = true;

  List<String> values;

  bool isRouding;

  @override
  void init() {
    final values = this.values;
    final tickCount = this.tickCount;

    if (this.ticks == null) {
      var ticks = values;
      if (tickCount > 0) {
        final temp = catAuto(
          maxCount: tickCount,
          data: values,
          isRounding: this.isRouding,
        );
        ticks = temp.ticks;
      }
      this.ticks = ticks;
    }
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
    var percent;

    final valueNum = this.translate(value);
    if (this.values.length > 1) {
      percent = valueNum / (this.values.length - 1);
    } else {
      percent = value;
    }
    return rangeMin + percent * (rangeMax - rangeMin);
  }

  @override
  String invert(double value) {
    final min = this.rangeMin();
    final max = this.rangeMax();

    value = value.clamp(min, max);
    final percent = (value - min) / (max - min);
    final index = (percent * (this.values.length - 1)).round() % this.values.length;
    return this.values[index];
  }

  @override
  Scale<String> clone() => CatScale(
    fieldList: this.fields,
    formatter: this.formatter,
    range: this.range,
    alias: this.alias,
    ticks: this.ticks,
    tickCount: this.tickCount,
    values: this.values,
    isRouding: this.isRouding,
  );
}
