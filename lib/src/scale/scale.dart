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
    this.range,
    this.alias,
    this.ticks,
    this.tickCount,
  }) : super(
    field: field,
    fieldList: fieldList,
  );

  final type = 'base';

  final ScaleFormatter formatter;

  final Range range;

  final String alias;

  final List<F> ticks;
  final int tickCount;

  List values = [];

  // Only value param used.
  String getText(F value) {
    final formatter = this.formatter;
    var rst = (formatter != null) ? formatter(value) : value?.toString;
    rst = rst ?? '';
    return rst;
  }

  double scale(F value);

  List<TickObj> getTicks() {
    final ticks = this.ticks;
    final rst = <TickObj>[];
    ticks.forEach((tick) {
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

  double invert(double value);

  double translate(F value);

  Scale<F> clone();
}
