import 'dart:math' show Point;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/chart/plot.dart' show Plot;
import 'package:aesth/src/coord/polar_coord.dart' show PolarCoord;

bool equal(num v1, num v2) => (v1 - v2).abs() < 0.001;

main() {
  group('coord circle', () {
    final plot = Plot(
      Point(0, 0),
      Point(400, 400),
    );
    group('with inner circle', () {
      final circle = PolarCoord(
        start: plot.bl,
        end: plot.tr,
        innerRadius: 0.5,
      );

      test('constructor', () {
        expect(circle.type, 'polar');
      });

      test('center', () {
        final center = circle.center;
        expect(center.x, 200);
        expect(center.y, 200);
      });

      test('radius', () {
        expect(circle.circleRadius, 200);
      });

      test('convertPoint', () {
        Point<num> p = Point(0, 0);
        p = circle.convertPoint(p);
        expect(p.x, 200);
        expect(p.y, 100);

        p = Point(0, 1);
        p = circle.convertPoint(p);
        expect(p.x, 200);
        expect(p.y, 0);

        p = Point(0.75, 0.5);
        p = circle.convertPoint(p);
        expect(equal(p.x, 50), true);
        expect(equal(p.y, 200), true);
      });

      test('invertPoint', () {
        Point<num> p = Point(200, 200);
        p = circle.invertPoint(p);
        expect(p.x, 0);
        expect(p.y, 0);

        p = Point(200, 0);
        p = circle.invertPoint(p);
        expect(p.x, 0);
        expect(p.y, 1);

        p = Point(50, 200);
        p = circle.invertPoint(p);
        expect(equal(p.x, 0.75), true);
        expect(equal(p.y, 0.5), true);
      });
    });
  });
}
