import './adjust.dart' show Adjust;

class Stack extends Adjust {
  Stack({
    String xField,
    String yField,

    this.reverseOrder = false,
  }) : super(
    xField: xField,
    yField: yField,
  );

  bool reverseOrder;

  @override
  List<List<Map<String, Object>>> processAdjust(List<List<Map<String, Object>>> dataArray) => this.processStack(dataArray);
  
  List<List<Map<String, Object>>> processStack(List<List<Map<String, Object>>> dataArray) {
    final xField = this.xField;
    final yField = this.yField;
    final count = dataArray.length;
    final stackCache = {
      'positive': <String, num>{},
      'negative': <String, num>{},
    };
    if (this.reverseOrder) {
      dataArray = dataArray.sublist(0).reversed.toList();
    }

    final rstArray = <List<Map<String, Object>>>[];
    for (var i = 0; i < count; i++) {
      final data = dataArray[i];

      final rstData = <Map<String, Object>>[];
      for (var j = 0, len = data.length; j < len; j++) {
        final item = data[j];
        final x = item[xField] ?? 0;
        final yRaw = item[yField];
        final xKey = x.toString();
        final y = yRaw is List ? yRaw[1] : yRaw;

        final rstObj = <String, Object>{};
        rstObj.addAll(item);

        if (y != null) {
          final yNum = y as num;
          final direction = yNum >= 0 ? 'positive' : 'negative';
          if (stackCache[direction][xKey] == null) {
            stackCache[direction][xKey] = 0;
          }
          rstObj[yField] = [stackCache[direction][xKey], yNum + stackCache[direction][xKey]];
          stackCache[direction][xKey] += yNum;
        }

        rstData.add(rstObj);
      }
      rstArray.add(rstData);
    }
    return rstArray;
  }
}
