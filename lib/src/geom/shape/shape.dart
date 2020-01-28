import 'dart:ui' show Offset;

import 'package:aesth/src/coord/coord.dart';
import 'package:aesth/src/global.dart';
import 'package:aesth/src/graphic/element.dart';

abstract class ShapeBase {
  Coord _coord;

  void draw(Map<String, Object> cfg, Element container);

  void setCoord(Coord coord) {
    this._coord = coord;
  }

  // convert the normalized value to the canvas position
  Offset parsePoint(Offset point) {
    final coord = this._coord;
    if (coord.isPolar) {
      point = Offset(
        point.dx == 1 ? 0.9999999 : point.dx,
        point.dy == 1 ? 0.9999999 : point.dy,
      );
    }
    return coord.convertPoint(point);
  }

  // convert the normalized value to the canvas position
  List<Offset> parsePoints(List<Offset> points) {
    if (points == null) {
      return null;
    }
    final rst = <Offset>[];
    points.forEach((point) {
      rst.add(this.parsePoint(point));
    });
    return rst;
  }

  List<Offset> getPoints(Map<String, Object> cfg);
}

abstract class ShapeFactoryBase {
  String defaultShapeType;
  
  Coord _coord;

  ShapeBase shape;

  void setCoord(Coord coord) {
    this._coord = coord;
  }

  ShapeBase getShape(String type);

  List<Offset> getShapePoints(String type, Map<String, Object> cfg) {
    final shape = this.getShape(type);
    final points = shape.getPoints(cfg);
    return points;
  }

  List<Offset> getDefaultPoints(Map<String, Object> cfg) => <Offset>[];

  void drawShape(String type, Map<String, Object> cfg, Element container) {
    final shape = this.getShape(type);
    if (cfg['color'] == null) {
      cfg['color'] = Global['colors'][0];
    }
    shape.draw(cfg, container);
  }
}
