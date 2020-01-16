import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/auto/number.dart' show numberAuto;

main() {
  group('test number auto', () {
    test('no interval', () {
      final rst = numberAuto(
        min: 0,
        max: 10,
      );
      expect(rst.ticks, [ 0, 2, 4, 6, 8, 10 ]);
    });

    test('no interval no nice', () {
      final rst = numberAuto(
        min: 1,
        max: 9.5,
      );
      expect(rst.ticks, [ 0, 2, 4, 6, 8, 10 ]);
    });

    test('no interval, max : 11', () {
      final rst = numberAuto(
        min: 1,
        max: 11,
      );
      expect(rst.ticks, [ 0, 2, 4, 6, 8, 10, 12 ]);
    });

    test('with interval', () {
      final rst = numberAuto(
        min: 0,
        interval: 5,
        max: 10,
      );
      expect(rst.ticks, [ 0, 5, 10 ]);
    });

    test('with interval not nice, larger', () {
      final rst = numberAuto(
        min: 1.2,
        interval: 5,
        max: 11.5,
      );
      expect(rst.ticks, [ 0, 5, 10, 15 ]);
    });

    test('with interval, not the multiple of interval', () {
      var rst = numberAuto(
        min: 0,
        interval: 6,
        max: 10,
      );
      expect(rst.ticks, [ 0, 6, 12 ]);

      rst = numberAuto(
        min: 3,
        interval: 6,
        max: 11,
      );
      expect(rst.ticks, [ 0, 6, 12 ]);
    });

    test('max < 0, min < 0', () {
      final rst = numberAuto(
        min: -100,
        interval: 20,
        max: -10,
      );
      expect(rst.ticks, [ -100, -80, -60, -40, -20, -0 ]);
    });

    test('with count', () {
      final rst = numberAuto(
        min: 0,
        minCount: 3,
        maxCount: 4,
        max: 10,
      );
      expect(rst.ticks, [ 0, 5, 10 ]);
    });

    test('with count', () {
      final rst = numberAuto(
        min: 0,
        minCount: 5,
        maxCount: 5,
        max: 4200,
      );
      expect(rst.ticks, [ 0, 1200, 2400, 3600, 4800 ]);
    });

    test('max equals min', () {
      var rst = numberAuto(
        min: 100,
        max: 100,
      );
      expect(rst.ticks, [ 0, 20, 40, 60, 80, 100 ]);

      rst = numberAuto(
        min: 0,
        max: 0,
      );
      expect(rst.ticks, [ 0, 1 ]);
    });

    test('max equals min', () {
      var rst = numberAuto(
        min: -10,
        max: -10,
      );
      expect(rst.max, 0);
      expect(rst.min, -10);
    });

    test('very little', () {
      final rst = numberAuto(
        min: 0.0002,
        minCount: 3,
        maxCount: 4,
        max: 0.0010,
      );
      expect(rst.ticks, [ 0, 0.0004, 0.0008, 0.0012 ]);
    });

    test('very little minus', () {
      final rst = numberAuto(
        min: -0.0010,
        minCount: 3,
        maxCount: 4,
        max: -0.0002,
      );
      expect(rst.ticks, [ -0.0012, -0.0008, -0.0004, 0 ]);
    });

    test('tick count 5', () {
      final rst = numberAuto(
        min: -5,
        minCount: 5,
        maxCount: 5,
        max: 605,
      );
      expect(rst.ticks, [ -160, 0, 160, 320, 480, 640 ]);
    });

    test('tick count 6', () {
      final rst = numberAuto(
        min: 0,
        minCount: 6,
        maxCount: 6,
        max: 100,
      );
      expect(rst.ticks, [ 0, 20, 40, 60, 80, 100 ]);
    });

    test('tick count 10', () {
      final rst = numberAuto(
        min: 0,
        minCount: 10,
        maxCount: 10,
        max: 5,
      );
      expect(rst.ticks, [ 0, 0.6, 1.2, 1.8, 2.4, 3.0, 3.6, 4.2, 4.8, 5.4 ]);
    });

    test('snapArray', () {
      final rst = numberAuto(
        min: 0,
        minCount: 6,
        maxCount: 6,
        snapArray: [ 0.3, 3, 6, 30 ],
        max: 1000,
      );
      expect(rst.ticks, [ 0, 300, 600, 900, 1200 ]);
    });

    test('tick count with limit 0', () {
      final rst = numberAuto(
        min: 200,
        minCount: 5,
        maxCount: 5,
        snapArray: [ 3, 6, 30 ],
        max: 5268,
        minLimit: 0,
      );
      expect(rst.ticks, [ 0, 3000, 6000 ]);
    });

    test('with count 5', () {
      final rst = numberAuto(
        min: 0,
        minCount: 5,
        maxCount: 5,
        max: 10,
      );
      expect(rst.ticks, [ 0, 2.5, 5, 7.5, 10 ]);
    });

    test('very small and float', () {
      var rst = numberAuto(
        min: 0,
        max: 0.0000267519,
      );
      expect(rst.ticks, [
        0,
        0.000005,
        0.00001,
        0.000015,
        0.00002,
        0.000025,
        0.00003,
      ]);

      rst = numberAuto(
        min: 0.0000237464,
        max: 0.0000586372
      );
      expect(rst.ticks, [
        0.00002,
        0.000025,
        0.00003,
        0.000035,
        0.00004,
        0.000045,
        0.00005,
        0.000055,
        0.00006,
      ]);
    });

    test('minTickInterval', () {
      final rst = numberAuto(
        min: 140,
        minTickInterval: 1,
        max: 141,
      );
      expect(rst.ticks, [ 140, 141 ]);
    });
  });
}