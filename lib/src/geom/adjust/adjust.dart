import 'dodge.dart';
import 'stack.dart';

abstract class Adjust {
  static Adjust create<V>(String type, [Map<String, Object> cfg]) {
    switch (type) {
      case 'dodge':
        return Dodge(
          xField: cfg['xField'],
          yField: cfg['yField'],

          marginRatio: cfg['marginRatio'],
          dodgeRatio: cfg['dodgeRatio'],
        );
      case 'stack':
        return Stack(
          xField: cfg['xField'],
          yField: cfg['yField'],

          reverseOrder: cfg['reverseOrder'],
        );
      default:
        return null;
    }
  }

  Adjust({
    this.xField,
    this.yField,
  });

  final adjustNames = ['x', 'y'];
  final type = 'base';

  String xField;
  String yField;

  List<List<Map<String, Object>>> processAdjust(List<List<Map<String, Object>>> dataArray);
}
