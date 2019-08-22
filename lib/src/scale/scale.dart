import 'package:aesth/src/util/measures.dart';

typedef ScaleFormatter<F> = String Function(F value);

class TickObj<F> {
  TickObj(this.text, this.tickValue, this.value);

  final String text;
  final F tickValue;
  final double value;
}

abstract class Scale<F> {
  Scale({
    this.field,
    this.formatter,
    this.range = const Range(0, 1),
    this.alias,
    this.ticks,
    this.tickCount,
  }) {
    this.init();
  }

  final type = 'base';

  final bool isCategory = false;

  final bool isLinear = false;

  String field;

  ScaleFormatter<F> formatter;

  Range range;

  String alias;

  List<F> ticks;
  int tickCount;

  void init();

  // Only value param used.
  String getText(Object value) {
    final formatter = this.formatter;
    var rst = (formatter != null) ? formatter(value) : value?.toString();
    rst = rst ?? '';
    return rst;
  }

  double scale(F value);

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

  double rangeMin() => this.range.min;

  double rangeMax() => this.range.max;

  /// value is num return inverted F, value is F return itself
  F invert(Object value);

  /// transform F to num, used within double scale(F value)
  num translate(F value);

  Scale<F> clone();

  void changeFields(Map<String, Object> info);

  Scale<F> change(Map<String, Object> info) {
    this.ticks = null;
    this.changeFields(info);
    this.init();
    return this;
  }
}
