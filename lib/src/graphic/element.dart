import 'dart:ui' show Canvas, Paint, PaintingStyle;

import './util/bbox.dart' show BBox;
import './util/matrix.dart' show Matrix, TransAction;
import './util/vector2.dart' show Vector2;
import './shape.dart' show Shape;

bool isUnchanged(Matrix m) =>
  m[0] == 1 && m[1] == 0 && m[2] == 0 && m[3] == 1 && m[4] == 0 && m[5] == 0;

abstract class Element {
  final isGroup = false;
  final isShape = false;

  num width;
  num height;
  int zIndex = 0;
  // index as a child
  int index;

  bool visible = true;
  bool destroyed = false;

  Element parent;
  List<Element> children;

  Paint paint;

  Shape clip;
  BBox bbox = BBox(0, 0, 0, 0);
  Matrix matrix = Matrix(1, 0, 0, 1, 0, 0);
  double x;
  double y;

  void draw(Canvas canvas) {
    if (this.destroyed) {
      return;
    }
    if (this.visible) {
      this.setCanvas(canvas);
      this.drawInner(canvas);
      canvas.restore();
    }
  }

  setCanvas(Canvas canvas) {
    canvas.save();
    if (clip != null) {
      clip.resetTransform(canvas);
      clip.createPath();
      canvas.clipPath(clip.path);
    }
    this.resetTransform(canvas);
  }

  bool hasFill() => this.paint.style == PaintingStyle.fill;

  bool hasStroke() => this.paint.style == PaintingStyle.stroke;

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

  void resetTransform(Canvas canvas) {
    final mo = this.matrix;
    if (!isUnchanged(mo)) {
      canvas.transform(mo.toCanvasMatrix());
    }
  }
}