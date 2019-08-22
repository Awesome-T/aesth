import 'package:aesth/src/graphic/util/bbox.dart';

import '../shape.dart' show Shape;

class Circle extends Shape {
  final type = 'circle';

  num r = 0;

  @override
  void createPath() {
    // TODO: implement createPath
  }

  @override
  BBox calculateBox() {
    // TODO: implement calculateBox
    return null;
  }
  
}