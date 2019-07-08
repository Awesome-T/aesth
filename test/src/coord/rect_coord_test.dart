import 'dart:math' show Point;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/chart/plot.dart' show Plot;
import 'package:aesth/src/coord/rect_coord.dart' show RectCoord;

main() {
  group('coord rect', () {
    final plot = Plot(
      Point(0, 0),
      Point(400, 400),
    );
    final rect = RectCoord(
      start: plot.bl,
      end: plot.tr,
    );

    test('constructor', () {
      expect(rect.type, 'cartesian');
    });

    test('convertPoint', () {
      Point<num> p = Point(0, 0);
      p = rect.convertPoint(p);
      expect(p.x, 0);
      expect(p.y, 400);

      p = Point(0, 1);
      p = rect.convertPoint(p);
      expect(p.x, 0);
      expect(p.y, 0);

      p = Point(1, 0.5);
      p = rect.convertPoint(p);
      expect(p.x, 400);
      expect(p.y, 200);

      p = Point(0.3, 0.7);
      p = rect.convertPoint(p);
      expect(p.x, 120);
      expect(p.y, 120);
    });

    test('invertPoint', () {
      Point<num> p = Point(200, 200);
      p = rect.invertPoint(p);
      expect(p.x, 0.5);
      expect(p.y, 0.5);

      p = Point(0, 400);
      p = rect.invertPoint(p);
      expect(p.x, 0);
      expect(p.y, 0);

      p = Point(400, 400);
      p = rect.invertPoint(p);
      expect(p.x, 1);
      expect(p.y, 0);

      p = Point(120, 120);
      p = rect.invertPoint(p);
      expect(p.x, 0.3);
      expect(p.y, 0.7);
    });

    final rect1 = RectCoord(
      start: plot.bl,
      end: plot.tr,
      transposed: true,
    );
    test('transposed convertPoint', () {
      Point<num> p = Point(0, 0);
      p = rect1.convertPoint(p);
      expect(p.x, 0);
      expect(p.y, 400);

      p = Point(1, 0.5);
      p = rect1.convertPoint(p);
      expect(p.x, 200);
      expect(p.y, 0);

      p = Point(0.5, 1);
      p = rect1.convertPoint(p);
      expect(p.x, 400);
      expect(p.y, 200);

      p = Point(0.3, 0.7);
      p = rect1.convertPoint(p);
      expect(p.x, 280);
      expect(p.y, 280);
    });

    test('transposed invertPoint', () {
      Point<num> p = Point(0, 400);
      p = rect1.invertPoint(p);
      expect(p.x, 0);
      expect(p.y, 0);

      p = Point(200, 0);
      p = rect1.invertPoint(p);
      expect(p.x, 1);
      expect(p.y, 0.5);

      p = Point(400, 200);
      p = rect1.invertPoint(p);
      expect(p.x, 0.5);
      expect(p.y, 1);

      p = Point(280, 280);
      p = rect1.invertPoint(p);
      expect(p.x, 0.3);
      expect(p.y, 0.7);
    });
  });
}
