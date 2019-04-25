import './element.dart';
import './util/bbox.dart' show BBox;

abstract class Shape extends Element {
  bool isShape = true;

  @override
  void drawInner() {
    // TODO: implement drawInner
  }

  BBox calculateBox();

}
