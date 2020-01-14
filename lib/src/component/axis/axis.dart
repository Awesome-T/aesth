import 'dart:ui';

import 'package:aesth/src/util/tool.dart' show FieldAttachable;

enum AxisPosition {
  top,
  right,
  bottom,
  left,
}

typedef AxisLineStyleCreator = Paint Function(String text, int index, int total);
typedef AxisTextStyleCreator = TextStyle Function(String text, int index, int total);

abstract class Axis extends FieldAttachable {
  Axis({
    String field,
    List<String> fieldList,

    this.show,
    this.position,
    this.line,
    this.labelOffset,
    this.grid,
    this.gridFunc,
    this.tickLine,
    this.tickLineFunc,
    this.label,
    this.labelFunc
  }) : super(
    field: field,
    fieldList: fieldList,
  );

  final bool show;

  final AxisPosition position;

  final Paint line;

  final num labelOffset;

  final Paint grid;
  final AxisLineStyleCreator gridFunc;

  final Paint tickLine;
  final AxisLineStyleCreator tickLineFunc;

  final TextStyle label;
  final AxisTextStyleCreator labelFunc;
}
