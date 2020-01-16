import 'dart:math' show pi;
import 'dart:ui' show Offset, Rect;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/coord/polar_coord.dart' show PolarCoord;

bool equal(num v1, num v2) => (v1 - v2).abs() < 0.001;

main() {
  group('coord circle', () {
    final plot = Rect.fromPoints(
      Offset(0, 0),
      Offset(400, 400),
    );
    group('with inner circle', () {
      final circle = PolarCoord(
        start: plot.bottomLeft,
        end: plot.topRight,
        innerRadius: 0.5,
      );

      test('constructor', () {
        expect(circle.type, 'polar');
      });

      test('center', () {
        final center = circle.center;
        expect(center.dx, 200);
        expect(center.dy, 200);
      });

      test('radius', () {
        expect(circle.circleRadius, 200);
      });

      test('convertPoint', () {
        Offset p = Offset(0, 0);
        p = circle.convertPoint(p);
        expect(p.dx, 200);
        expect(p.dy, 100);

        p = Offset(0, 1);
        p = circle.convertPoint(p);
        expect(p.dx, 200);
        expect(p.dy, 0);

        p = Offset(0.75, 0.5);
        p = circle.convertPoint(p);
        expect(equal(p.dx, 50), true);
        expect(equal(p.dy, 200), true);
      });

      test('invertPoint', () {
        Offset p = Offset(200, 100);
        p = circle.invertPoint(p);
        expect(p.dx, 0);
        expect(p.dy, 0);

        p = Offset(200, 0);
        p = circle.invertPoint(p);
        expect(p.dx, 0);
        expect(p.dy, 1);

        p = Offset(50, 200);
        p = circle.invertPoint(p);
        expect(equal(p.dx, 0.75), true);
        expect(equal(p.dy, 0.5), true);
      });
    });

    group('no inner', () {
      final circle1 = PolarCoord(
        start: plot.bottomLeft,
        end: plot.topRight,
        innerRadius: 0,
      );

      test('radius', () {
        expect(circle1.radius, null);
      });

      test('circleRadius', () {
        expect(circle1.circleRadius, 200);
      });

      test('inner convertPoint', () {
        Offset p = Offset(0, 0);
        p = circle1.convertPoint(p);
        expect(p.dx, 200);
        expect(p.dy, 200);

        p = Offset(0.5, 0);
        p = circle1.convertPoint(p);
        expect(p.dx, 200);
        expect(p.dy, 200);

        p = Offset(0.5, 0.5);
        p = circle1.convertPoint(p);
        expect(p.dx, 200);
        expect(p.dy, 300);
      });

      test('inner invertPoint', () {
        Offset p = Offset(200, 200);
        p = circle1.invertPoint(p);
        expect(p.dx, 0);
        expect(p.dy, 0);

        p = Offset(200, 300);
        p = circle1.invertPoint(p);
        expect(p.dx, 0.5);
        expect(p.dy, 0.5);
      });
    });
    
    group('half circle', () {
      final circle = PolarCoord(
        start: plot.bottomLeft,
        end: plot.topRight,
        startAngle: -pi,
        endAngle: 0,
      );

      test('init', () {
        expect(circle.radius, null);
        expect(circle.circleRadius, 200);
      });

      test('convert point', () {
        final p = circle.convertPoint(Offset(0, 0));
        expect(p, Offset(200, 400));

        final p1 = circle.convertPoint(Offset(0, 1));
        expect(p1, Offset(0, 400));

        final p2 = circle.convertPoint(Offset(0.5, 1));
        expect(p2, Offset(200, 200));
      });

      test('invert point', () {
        expect(circle.invertPoint(Offset(200, 400)), Offset(0, 0));
        expect(circle.invertPoint(Offset(200, 200)), Offset(0.5, 1));
      });
    });

    group('set radius', () {
      final circle5 = PolarCoord(
        start: plot.bottomLeft,
        end: plot.topRight,
        radius: 0.6,
      );

      test('radius', () {
        expect(circle5.radius, 0.6);
      });

      test('circleRadius', () {
        expect(circle5.circleRadius, 120);
      });

      test('reset', () {
        final newPlot = Rect.fromPoints(
          Offset(0, 0),
          Offset(200, 200),
        );
        circle5.reset(newPlot);
        expect(circle5.radius, 0.6);
        expect(circle5.circleRadius, 60);
        expect(circle5.start, Offset(0, 200));
        expect(circle5.end, Offset(200, 0));
      });
    });
  });
}
