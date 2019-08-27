import 'dart:ui' show Canvas, Rect;
import 'dart:math' show min, max;

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
  Rect getBBox() {
    final children = this.children;
    for (var child in children) {
      if (child.visible) {
        final box = child.getBBox();
        if (box != null) {
          this.bbox = this.bbox.expandToInclude(box);
        }
      }
    }
    return this.bbox;
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