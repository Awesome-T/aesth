import 'dart:ui' show Canvas;
import 'dart:math' show min, max;

import './util/bbox.dart' show BBox;
import './util/vector2.dart' show Vector2;
import './element.dart' show Element;
import './container.dart' show Container;

class Group extends Element with Container {
  final isGroup = true;

  List<Element> children = <Element>[];

  @override
  void drawInner(Canvas canvas) {
    final children = this.children;
    for (var child in children) {
      child.draw(canvas);
    }
  }

  @override
  BBox getBBox() {
    var minX = double.infinity;
    var maxX = double.negativeInfinity;
    var minY = double.infinity;
    var maxY = double.negativeInfinity;
    final children = this.children;
    for (var child in children) {
      if (child.visible) {
        final box = child.getBBox();
        if (box == null) {
          continue;
        }

        final leftTop = Vector2(box.minX, box.minY);
        final leftBottom = Vector2(box.minX, box.maxY);
        final rightTop = Vector2(box.maxX, box.minY);
        final rightBottom = Vector2(box.maxX, box.maxY);
        final matrix = child.matrix;

        leftTop.transformMat2d(matrix);
        leftBottom.transformMat2d(matrix);
        rightTop.transformMat2d(matrix);
        rightBottom.transformMat2d(matrix);

        minX = [leftTop.x, leftBottom.x, rightTop.x, rightBottom.x].reduce(min);
        maxX = [leftTop.x, leftBottom.x, rightTop.x, rightBottom.x].reduce(max);
        minY = [leftTop.y, leftBottom.y, rightTop.y, rightBottom.y].reduce(min);
        maxY = [leftTop.y, leftBottom.y, rightTop.y, rightBottom.y].reduce(max);
      }
    }

    return BBox(minX, minY, maxX, maxY);
  }

  @override
  void destroy() {
    if (this.destroyed) {
      return;
    }
    this.clear();
    super.destroy();
  }
}