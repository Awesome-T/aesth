import 'package:aesth/src/base.dart';
import 'package:aesth/src/util/measures.dart';

typedef ScaleFormatter<F> = String Function(F value);

class TickObj<F> {
  TickObj(this.text, this.tickValue, this.value);

  final String text;
  final F tickValue;
  final double value;
}

abstract class Scale<F> extends FieldAttachable {
  Scale({
    String field,
    List<String> fieldList,

    this.formatter,
    this.range = const Range(0, 1),
    this.alias,
    this.ticks,
    this.tickCount,
  }) : super(
    field: field,
    fieldList: fieldList,
  ) {
    this.init();
  }

  final type = 'base';

  ScaleFormatter formatter;

  Range range;

  String alias;

  List<F> ticks;
  int tickCount;

  void init();

  // Only value param used.
  String getText(F value) {
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

  F invert(double value);

  num translate(F value);

  Scale<F> clone();

  /// In dart explicitly set class fields
  ///   before using change() method
  Scale change() {
    this.ticks = null;
    this.init();
    return this;
  }
}
