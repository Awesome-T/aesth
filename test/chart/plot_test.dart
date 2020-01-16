import 'dart:ui' show Offset, Rect;

import 'package:flutter_test/flutter_test.dart';

main() {
  group('plot', () {
    final plot = Rect.fromPoints(
      Offset(400, 0),
      Offset(0, 400),
    );

    test('isInRange', () {
      final p = Offset(250, 350);
      expect(plot.contains(p), true);

      expect(plot.contains(Offset(300, 500)), false);
      expect(plot.contains(Offset(200, 300)), true);
    });

    test('width', () {
      expect(plot.width, 400);
    });

    test('height', () {
      expect(plot.height, 400);
    });

    test('tl', () {
      final tl = plot.topLeft;
      expect(tl.dx, 0);
      expect(tl.dy, 0);
    });

    test('tr', () {
      final tr = plot.topRight;
      expect(tr.dx, 400);
      expect(tr.dy, 0);
    });

    test('bl', () {
      final bl = plot.bottomLeft;
      expect(bl.dx, 0);
      expect(bl.dy, 400);
    });

    test('br', () {
      final br = plot.bottomRight;
      expect(br.dx, 400);
      expect(br.dy, 400);
    });
  });
}
