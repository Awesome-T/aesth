import 'dart:ui' show Offset, Rect;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/coord/rect_coord.dart' show RectCoord;

main() {
  group('coord rect', () {
    final plot = Rect.fromPoints(
      Offset(0, 0),
      Offset(400, 400),
    );
    final rect = RectCoord(
      start: plot.bottomLeft,
      end: plot.topRight,
    );

    test('constructor', () {
      expect(rect.type, 'cartesian');
    });

    test('convertPoint', () {
      Offset p = Offset(0, 0);
      p = rect.convertPoint(p);
      expect(p.dx, 0);
      expect(p.dy, 400);

      p = Offset(0, 1);
      p = rect.convertPoint(p);
      expect(p.dx, 0);
      expect(p.dy, 0);

      p = Offset(1, 0.5);
      p = rect.convertPoint(p);
      expect(p.dx, 400);
      expect(p.dy, 200);

      p = Offset(0.3, 0.7);
      p = rect.convertPoint(p);
      expect(p.dx, 120);
      expect(p.dy, 120);
    });

    test('invertPoint', () {
      Offset p = Offset(200, 200);
      p = rect.invertPoint(p);
      expect(p.dx, 0.5);
      expect(p.dy, 0.5);

      p = Offset(0, 400);
      p = rect.invertPoint(p);
      expect(p.dx, 0);
      expect(p.dy, 0);

      p = Offset(400, 400);
      p = rect.invertPoint(p);
      expect(p.dx, 1);
      expect(p.dy, 0);

      p = Offset(120, 120);
      p = rect.invertPoint(p);
      expect(p.dx, 0.3);
      expect(p.dy, 0.7);
    });

    final rect1 = RectCoord(
      start: plot.bottomLeft,
      end: plot.topRight,
      transposed: true,
    );
    test('transposed convertPoint', () {
      Offset p = Offset(0, 0);
      p = rect1.convertPoint(p);
      expect(p.dx, 0);
      expect(p.dy, 400);

      p = Offset(1, 0.5);
      p = rect1.convertPoint(p);
      expect(p.dx, 200);
      expect(p.dy, 0);

      p = Offset(0.5, 1);
      p = rect1.convertPoint(p);
      expect(p.dx, 400);
      expect(p.dy, 200);

      p = Offset(0.3, 0.7);
      p = rect1.convertPoint(p);
      expect(p.dx, 280);
      expect(p.dy, 280);
    });

    test('transposed invertPoint', () {
      Offset p = Offset(0, 400);
      p = rect1.invertPoint(p);
      expect(p.dx, 0);
      expect(p.dy, 0);

      p = Offset(200, 0);
      p = rect1.invertPoint(p);
      expect(p.dx, 1);
      expect(p.dy, 0.5);

      p = Offset(400, 200);
      p = rect1.invertPoint(p);
      expect(p.dx, 0.5);
      expect(p.dy, 1);

      p = Offset(280, 280);
      p = rect1.invertPoint(p);
      expect(p.dx, 0.3);
      expect(p.dy, 0.7);
    });
  });
}
