import 'dart:math' show Point;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/chart/plot.dart' show Plot;

main() {
  group('plot', () {
    final plot = Plot(
      Point(400, 0),
      Point(0, 400),
    );

    test('isInRange', () {
      final p = Point(250, 350);
      expect(plot.isInRange(p), true);

      expect(plot.isInRange(Point(300, 500)), false);
      expect(plot.isInRange(Point(200, 300)), true);
    });

    test('width', () {
      expect(plot.width, 400);
    });

    test('height', () {
      expect(plot.height, 400);
    });

    test('tl', () {
      final tl = plot.tl;
      expect(tl.x, 0);
      expect(tl.y, 0);
    });

    test('tr', () {
      final tr = plot.tr;
      expect(tr.x, 400);
      expect(tr.y, 0);
    });

    test('bl', () {
      final bl = plot.bl;
      expect(bl.x, 0);
      expect(bl.y, 400);
    });

    test('br', () {
      final br = plot.br;
      expect(br.x, 400);
      expect(br.y, 400);
    });

    test('reset', () {
      plot.reset(
        Point(0, 0),
        Point(300, 200),
      );
      expect(plot.width, 300);
      expect(plot.height, 200);
    });
  });
}
