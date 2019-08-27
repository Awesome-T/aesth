import 'dart:ui' show Canvas, Rect;

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
    var groupBox = Rect.zero;
    final children = this.children;
    for (var child in children) {
      if (child.visible) {
        final box = child.getBBox();
        if (box != null) {
          groupBox = groupBox.expandToInclude(box);
        }
      }
    }
    return groupBox;
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