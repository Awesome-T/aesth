import 'dart:ui' show Canvas, Paint;

import './util/bbox.dart' show BBox;
import './util/matrix.dart' show Matrix, TransAction;
import './util/vector2.dart' show Vector2;

bool isUnchanged(Matrix m) =>
  m[0] == 1 && m[1] == 0 && m[2] == 0 && m[3] == 1 && m[4] == 0 && m[5] == 0;

abstract class Element {
  Element({
    this.paint,
    this.width,
    this.height,
    this.zIndex,
    this.visible,
    this.destroyed,
    this.parent,
    this.children,
    this.bbox,
    this.matrix,
    this.x,
    this.y,
  });

  final isGroup = false;
  final isShape = false;

  Paint paint;
  num width;
  num height;
  int zIndex = 0;
  bool visible = true;
  bool destroyed = false;
  Element parent;
  List<Element> children;
  BBox bbox = BBox(0, 0, 0, 0);
  Matrix matrix = Matrix(1, 0, 0, 1, 0, 0);
  double x;
  double y;

  void draw(Canvas canvas) {
    if (this.destroyed) {
      return;
    }
    if (this.visible) {
      this.drawInner(canvas);
    }
  }

  void drawInner(Canvas canvas);

  Element show() {
    this.visible = true;
    return this;
  }

  Element hide() {
    this.visible = false;
    return this;
  }

  Element _removeFromParent() {
    final parent = this.parent;
    if (parent != null) {
      parent.children.remove(this);
    }

    return this;
  }

  void remove(bool destroy) {
    if (destroy) {
      this.destroy();
    } else {
      this._removeFromParent();
    }
  }

  void destroy() {
    final destroyed = this.destroyed;

    if (destroyed) {
      return;
    }

    this._removeFromParent();

    this.destroyed = true;
  }

  Element transform(List<TransAction> actions) {
    this.matrix.transform(actions);
    return this;
  }

  Element setTransform(List<TransAction> actions) {
    this.matrix = Matrix(1, 0, 0, 1, 0, 0);
    return this.transform(actions);
  }

  void translate(double x, double y) {
    this.matrix.translate(Vector2(x, y));
  }

  void rotate(double rad) {
    this.matrix.rotate(rad);
  }

  void scale(double sx, double sy) {
    this.matrix.scale(Vector2(sx, sy));
  }

  void moveTo(x, y) {
    final cx = this.x ?? 0;
    final cy = this.y ?? 0;
    this.translate(x - cx, y - cy);
    this.x = x;
    this.y = y;
  }

  Element apply(Vector2 v) {
    final m = this.matrix;
    v.transformMat2d(m);
    return this;
  }
}