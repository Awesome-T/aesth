import './adjust.dart' show Adjust;

const _marginRatio = 1 / 2;
const _dodgeRatio = 1 / 2;

class Range {
  Range(this.pre, this.next);

  num pre;
  num next;
}

class Dodge extends Adjust {
  Dodge({
    String xField,
    String yField,

    this.marginRatio = _marginRatio,
    this.dodgeRatio = _dodgeRatio,
  }) : super(
    xField: xField,
    yField: yField,
  );

  num marginRatio;
  num dodgeRatio;

  num getDodgeOffset(Range range, int index, int count) {
    final pre = range.pre;
    final next = range.next;
    final tickLength = next - pre;
    final width = (tickLength * this.dodgeRatio) / count;
    final margin = this.marginRatio * width;
    final offset = 1 / 2 * (tickLength - (count) * width - (count - 1) * margin) +
      ((index + 1) * width + index * margin) -
      1 / 2 * width - 1 / 2 * tickLength;
    return (pre + next) / 2 + offset;
  }

  @override
  List<List<Map<String, Object>>> processAdjust(List<List<Map<String, Object>>> dataArray) {
    final count = dataArray.length;
    final xField = this.xField;

    final rstArray = <List<Map<String, Object>>>[];
    for (var index = 0; index < dataArray.length; index++) {
      final data = dataArray[index];

      final rstData = <Map<String, Object>>[];
      for (var i = 0, len = data.length; i < len; i++) {
        final obj = data[i];
        final value = obj[xField] as num;
        final range = Range(
          len == 1 ? value - 1 : value - 0.5,
          len == 1 ? value + 1 : value + 0.5,
        );
        final dodgeValue = this.getDodgeOffset(range, index, count);

        final rstObj = <String, Object>{};
        rstObj.addAll(obj);

        rstObj[xField] = dodgeValue;
        
        rstData.add(rstObj);
      }
      rstArray.add(rstData);
    }
    return rstArray;
  }
}
