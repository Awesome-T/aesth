import 'dart:math' show Point, pi;

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
        Point<num> p = Point(200, 100);
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

    group('no inner', () {
      final circle1 = PolarCoord(
        start: plot.bl,
        end: plot.tr,
        innerRadius: 0,
      );

      test('radius', () {
        expect(circle1.radius, null);
      });

      test('circleRadius', () {
        expect(circle1.circleRadius, 200);
      });

      test('inner convertPoint', () {
        Point<num> p = Point(0, 0);
        p = circle1.convertPoint(p);
        expect(p.x, 200);
        expect(p.y, 200);

        p = Point(0.5, 0);
        p = circle1.convertPoint(p);
        expect(p.x, 200);
        expect(p.y, 200);

        p = Point(0.5, 0.5);
        p = circle1.convertPoint(p);
        expect(p.x, 200);
        expect(p.y, 300);
      });

      test('inner invertPoint', () {
        Point<num> p = Point(200, 200);
        p = circle1.invertPoint(p);
        expect(p.x, 0);
        expect(p.y, 0);

        p = Point(200, 300);
        p = circle1.invertPoint(p);
        expect(p.x, 0.5);
        expect(p.y, 0.5);
      });
    });
    
    group('half circle', () {
      final circle = PolarCoord(
        start: plot.bl,
        end: plot.tr,
        startAngle: -pi,
        endAngle: 0,
      );

      test('init', () {
        expect(circle.radius, null);
        expect(circle.circleRadius, 200);
      });

      test('convert point', () {
        final p = circle.convertPoint(Point<num>(0, 0));
        expect(p, Point<num>(200, 400));

        final p1 = circle.convertPoint(Point<num>(0, 1));
        expect(p1, Point<num>(0, 400));

        final p2 = circle.convertPoint(Point<num>(0.5, 1));
        expect(p2, Point<num>(200, 200));
      });

      test('invert point', () {
        expect(circle.invertPoint(Point<num>(200, 400)), Point<num>(0, 0));
        expect(circle.invertPoint(Point<num>(200, 200)), Point<num>(0.5, 1));
      });
    });

    group('set radius', () {
      final circle5 = PolarCoord(
        start: plot.bl,
        end: plot.tr,
        radius: 0.6,
      );

      test('radius', () {
        expect(circle5.radius, 0.6);
      });

      test('circleRadius', () {
        expect(circle5.circleRadius, 120);
      });

      test('reset', () {
        final newPlot = Plot(
          Point(0, 0),
          Point(200, 200),
        );
        circle5.reset(newPlot);
        expect(circle5.radius, 0.6);
        expect(circle5.circleRadius, 60);
        expect(circle5.start, Point(0, 200));
        expect(circle5.end, Point(200, 0));
      });
    });
  });
}
