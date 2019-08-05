import 'dart:math';

import 'package:aesth/src/coord/coord.dart';
import 'package:aesth/src/scale/scale.dart';

import 'attr.dart';

class PositionAttr extends Attr<num> {
  PositionAttr({
    String field,
    List<String> fieldList,
    List<num> values,
    num value,
    AttrCallback callback,
    List<Scale> scales,

    this.coord,
  }) : super(
    field: field,
    fieldList: fieldList,
    values: values,
    value: value,
    callback: callback,
    scales: scales,
  );

  final names = ['x', 'y'];
  
  final type = 'position';

  Coord coord;

  @override
  List<num> mapping(List<Object> params) {
    if (params?.length < 2) {
      return <num>[];
    }
    var x = params[0];
    var y = params[1];
    final scales = this.scales;
    final coord = this.coord;
    final scaleX = scales[0];
    final scaleY = scales[1];
    var rstX;
    var rstY;
    var obj;
    if (y is List && x is List) {
      rstX = [];
      rstY = [];
      for (var i = 0, j = 0, xLen = x.length, yLen = y.length; i < xLen && j < yLen; i++, j++) {
        obj = coord.convertPoint(Point(
          scaleX.scale(x[i]),
          scaleY.scale(y[j]),
        ));
        rstX.push(obj.x);
        rstY.push(obj.y);
      }
    } else if (y is List) {
      x = scaleX.scale(x);
      rstY = [];
      y.forEach((yVal) {
        yVal = scaleY.scale(yVal);
        obj = coord.convertPoint(Point(
          x,
          yVal,
        ));
        if (rstX != null && rstX != obj.x) {
          if (!(rstX is List)) {
            rstX = [rstX];
          }
          rstX.push(obj.x);
        } else {
          rstX = obj.x;
        }
        rstY.push(obj.y);
      });
    } else if (x is List) {
      y = scaleY.scale(y);
      rstX = [];
      x.forEach((xVal) {
        xVal = scaleY.scale(xVal);
        obj = coord.convertPoint(Point(
          xVal,
          y,
        ));
        if (rstY != null && rstY != obj.y) {
          if (!(rstY is List)) {
            rstY = [rstY];
          }
          rstY.push(obj.y);
        } else {
          rstY = obj.y;
        }
        rstX.push(obj.x);
      });
    } else {
      x = scaleX.scale(x);
      y = scaleY.scale(y);
      final point = coord.convertPoint(Point(
        x,
        y,
      ));
      rstX = point.x;
      rstY = point.y;
    }
    return [rstX, rstY];
  }
}
