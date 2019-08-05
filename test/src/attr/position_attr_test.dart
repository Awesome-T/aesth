import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

import 'package:aesth/src/attr/position_attr.dart' show PositionAttr;
import 'package:aesth/src/scale/cat_scale.dart' show CatScale;
import 'package:aesth/src/scale/linear_scale.dart' show LinearScale;
import 'package:aesth/src/coord/coord.dart' show Coord;

class MyCoord extends Coord {
  void init(Point start, Point end) {}

  Point convertPoint(Point point) => Point(
    point.x * 100,
    point.y * 100,
  );

  Point invertPoint(Point point) => null;
}

main() {
  group('attr test size', () {
    final scaleCat = CatScale(
      field: 'type',
      values: [ 'a', 'b', 'c', 'd' ],
    );

    final scaleLinear = LinearScale(
      field: 'age',
      min: 0,
      max: 10,
    );

    final coord = MyCoord();

    final position = PositionAttr(
      scales: [scaleCat, scaleLinear],
      coord: coord,
    );

    test('init', () {
      expect(position.type, 'position');
      expect(position.getNames().length, 2);
    });

    test('mapping x,y', () {
      final rst = position.mapping(['a', 3]);
      expect(rst, [0, 60]);
    });

    test('mapping x, [y1,y2]', () {
      final rst = position.mapping(['b', [4, 6]]);
      expect(rst, [25, [80, 120]]);
    });

    test('mapping [x1,x2], y', () {
      final rst = position.mapping([['b', 'c'], 8]);
      expect(rst, [[25, 50], 160]);
    });

    test('mapping [x1,x2], [y1, y2]', () {
      final rst = position.mapping([['b', 'c', 'd'], [4, 6, 10]]);
      expect(rst, [[25, 50, 75], [80, 120, 200]]);
    });

    test('mapping x, y 0', () {
      final rst = position.mapping(['a', 0]);
      expect(rst, [0, 0]);
    });
  });
}
