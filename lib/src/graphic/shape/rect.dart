import 'dart:ui' as ui;

import 'package:aesth/src/util/tool.dart' show parseQuartet;

import '../shape.dart' show Shape;

class Rect extends Shape {
  Rect({
    this.x,
    this.y,
    this.width,
    this.height,
    this.radius,
  });

  final type = 'rect';

  num x = 0;
  num y = 0;
  num width = 0;
  num height = 0;
  // num or [tl, tr, br, bl]
  Object radius = 0;

  @override
  void createPath() {
    this.path = ui.Path();
    final rect = ui.Rect.fromLTWH(this.x, this.y, this.width, this.height);
    if (this.radius == null) {
      this.path.addRect(rect);
    } else {
      final radiusList = parseQuartet<num>(this.radius);
      this.path.addRRect(ui.RRect.fromRectAndCorners(
        rect,
        topLeft: ui.Radius.circular(radiusList[0]),
        topRight: ui.Radius.circular(radiusList[1]),
        bottomRight: ui.Radius.circular(radiusList[2]),
        bottomLeft: ui.Radius.circular(radiusList[3]),
      ));
    }
  }
}
