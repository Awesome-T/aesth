import 'package:aesth/src/coord/coord.dart';

import 'attr.dart';

class PositionAttr extends Attr<num> {
  PositionAttr({
    String field,
    List<String> fieldList,

    this.coord,
  }) : super(
    field: field,
    fieldList: fieldList,
  );

  final names = ['x', 'y'];
  
  final type = 'position';

  Coord coord;

  @override
  List<num> mapping(List<Object> params) {
    if (params?.length < 2) {
      return <num>[];
    }
    final x = params[0];
    final y = params[1];
    final scales = this.scales;
    final coord = this.coord;
    var rstX;
    var rstY;
    var obj;
    if (y is List && x is List) {
      rstX = [];
      rstY = [];
    }
  }
}
