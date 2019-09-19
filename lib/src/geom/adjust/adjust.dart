abstract class Adjust {
  Adjust({
    this.xField,
    this.yField,
  });

  final adjustNames = ['x', 'y'];

  String xField;
  String yField;

  List<List<Map<String, Object>>> processAdjust(List<List<Map<String, Object>>> dataArray);
}
