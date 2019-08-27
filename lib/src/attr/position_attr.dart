import 'dart:math';
import 'dart:ui' show Offset;

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
  List mapping(List params) {
    if (params?.length < 2) {
      return [];
    }
    var x = params[0];
    var y = params[1];
    final scales = this.scales;
    final coord = this.coord;
    final scaleX = scales[0];
    final scaleY = scales[1];
    var rstX;
    var rstY;
    Offset obj;
    if (y is List && x is List) {
      rstX = [];
      rstY = [];
      for (var i = 0, j = 0, xLen = x.length, yLen = y.length; i < xLen && j < yLen; i++, j++) {
        obj = coord.convertPoint(Offset(
          scaleX.scale(x[i]),
          scaleY.scale(y[j]),
        ));
        rstX.add(obj.dx);
        rstY.add(obj.dy);
      }
    } else if (y is List) {
      x = scaleX.scale(x);
      rstY = [];
      y.forEach((yVal) {
        yVal = scaleY.scale(yVal);
        obj = coord.convertPoint(Offset(
          x,
          yVal,
        ));
        if (rstX != null && rstX != obj.dx) {
          if (!(rstX is List)) {
            rstX = [rstX];
          }
          rstX.add(obj.dx);
        } else {
          rstX = obj.dx;
        }
        rstY.add(obj.dy);
      });
    } else if (x is List) {
      y = scaleY.scale(y);
      rstX = [];
      x.forEach((xVal) {
        xVal = scaleX.scale(xVal);
        obj = coord.convertPoint(Offset(
          xVal,
          y,
        ));
        if (rstY != null && rstY != obj.dy) {
          if (!(rstY is List)) {
            rstY = [rstY];
          }
          rstY.add(obj.dy);
        } else {
          rstY = obj.dy;
        }
        rstX.add(obj.dx);
      });
    } else {
      x = scaleX.scale(x);
      y = scaleY.scale(y);
      final point = coord.convertPoint(Offset(
        x,
        y,
      ));
      rstX = point.dx;
      rstY = point.dy;
    }
    return [rstX, rstY];
  }
}
