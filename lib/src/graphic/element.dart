import 'dart:ui' show Canvas, Paint, PaintingStyle, Rect;

import 'package:aesth/src/util/common.dart' show mix;

import './util/matrix.dart' show Matrix, TransAction;
import './util/vector2.dart' show Vector2;
import './shape.dart' show Shape;

bool isUnchanged(Matrix m) =>
  m[0] == 1 && m[1] == 0 && m[2] == 0 && m[3] == 1 && m[4] == 0 && m[5] == 0;

const ALIAS_ATTRS_MAP = {
  'stroke': 'strokeStyle',
  'fill': 'fillStyle',
  'opacity': 'globalAlpha',
};

const SHAPE_ATTRS = [
  'fillStyle',
  'font',
  'globalAlpha',
  'lineCap',
  'lineWidth',
  'lineJoin',
  'miterLimit',
  'shadowBlur',
  'shadowColor',
  'shadowOffsetX',
  'shadowOffsetY',
  'strokeStyle',
  'textAlign',
  'textBaseline',
  'lineDash',
  'shadow',
];

const CLIP_SHAPES = [ 'circle', 'sector', 'polygon', 'rect', 'polyline' ];

class Element {
  Element(Map<String, Object> cfg) {
    this._initProperties();
    mix([this._attrs, cfg]);

    final attrs = this._attrs['attrs'];
    if (attrs != null) {
      this.initAttrs(attrs);
    }

    this.initTransform();
  }

  Map<String, Object> _attrs;

  void _initProperties() {
    this._attrs = {
      'zIndex': 0,
      'visible': true,
      'destroyed': false,
    };
  }

  Object get(String name) {
    return this._attrs[name];
  }

  void set(String name, Object value) {
    this._attrs[name] = value;
  }

  bool isGroup() {
    return this.get('isGroup') as bool;
  }

  bool isShape() {
    return this.get('isShape') as bool;
  }

  void initAttrs(Map<String, Object> attrs) {
    this.attr(mix([this.getDefaultAttrs(), attrs]));
  }

  Map<String, Object> getDefaultAttrs() {
    return {};
  }

  void _setAttr(String name, Object value) {
    final attrs = this._attrs['attrs'] as Map<String, Object>;
    if (name == 'clip') {
      value = this._setAttrClip(value);
    } else {
      final alias = ALIAS_ATTRS_MAP[name];
      if (alias != null) {
        attrs[alias] = value;
      }
    }
    attrs[name] = value;
  }

  Object _getAttr(String name) {
    return (this._attrs['attrs'] as Map<String, Object>)[name];
  }

  void _setAttrClip()
}
