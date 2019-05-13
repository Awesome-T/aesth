import 'package:aesth/src/util/measures.dart';

import 'scale.dart';
import './auto/cat.dart' show catAuto;

class CatScale<F> extends Scale<F> {
  CatScale({
    String field,
    List<String> fieldList,
    ScaleFormatter formatter,
    Range range,
    String alias,
    List<F> ticks,
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

  List<F> values;

  bool isRouding;

  @override
  void init() {
    final values = this.values;
    final tickCount = this.tickCount;

    if (this.ticks == null) {
      var ticks = values;
      if (tickCount != null && tickCount > 0) {
        final temp = catAuto<F>(
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
  num translate(Object value) {
    num index;
    if (value is num) {
      index = value;
    } else {
      index = this.values.indexOf(value);
    }
    if (index == -1) {
      index = double.nan;
    }
    return index;
  }

  @override
  double scale(Object value) {
    final rangeMin = this.rangeMin();
    final rangeMax = this.rangeMax();
    var percent;

    num valueNum;
    if (value is num) {
      valueNum = value;
    } else {
      valueNum = this.translate(value);
    }
    
    if (this.values.length > 1) {
      percent = valueNum / (this.values.length - 1);
    } else {
      percent = value;
    }
    return rangeMin + percent * (rangeMax - rangeMin);
  }

  @override
  F invert(Object value) {
    if (value is num) {
      final min = this.rangeMin();
      final max = this.rangeMax();

      final percent = (value.clamp(min, max) - min) / (max - min);
      final index = (percent * (this.values.length - 1)).round() % this.values.length;
      return this.values[index];
    }
    if (value is F) {
      return value;
    }
    return null;
  }

  @override
  String getText(Object value) {
    if (value is num) {
      return super.getText(this.values[value.round()]);
    }
    return super.getText(value);
  }

  @override
  CatScale<F> clone() => CatScale(
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
