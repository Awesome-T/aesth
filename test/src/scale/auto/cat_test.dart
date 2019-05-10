import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/auto/cat.dart' show catAuto;

main() {
  group('Category test', () {
    test('no tick count, 1 items', () {
      final data = [ 1 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 2 items', () {
      final data = [ 1, 2 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 3 items', () {
      final data = [ 1, 2, 3 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 4 items', () {
      final data = [ 1, 2, 3, 4 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 5 items', () {
      final data = [ 1, 2, 3, 4, 5 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 6 items', () {
      final data = [ 1, 2, 3, 4, 5, 6 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 7 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 8 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
      final rst = catAuto(
        data: data,
        maxCount: 7,
      );
      expect(rst.ticks, data);
    });

    test('no tick count, 9 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
      final rst = catAuto(
        data: data,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 3, 5, 7, 9 ]);
    });

    test('no tick count, 10 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
      final rst = catAuto(
        data: data,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 4, 7, 10 ]);
    });

    test('no tick count, 14 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ];
      final rst = catAuto(
        data: data,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 3, 5, 7, 9, 11, 14 ]);
    });

    test('no tick count, 15 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, [ 1, 3, 5, 7, 9, 11, 13, 15 ]);
    });

    test('no tick count, 18 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 ];
      final rst = catAuto(
        data: data,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 5, 9, 13, 18 ]);
    });

    test('no tick count, 20 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 ];
      final rst = catAuto(
        data: data,
        maxCount: 5,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 7, 13, 20 ]);
    });

    test('no tick count, 27 items', () {
      final data = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 ];
      final rst = catAuto(
        data: data,
        maxCount: 12,
        isRounding: true,
      );
      expect(rst.ticks, [ 0, 3, 6, 9, 12, 15, 18, 21, 26 ]);
    });

    test('no tick count, 30 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 ];
      final rst = catAuto(
        data: data,
      );
      expect(rst.ticks, [ 1, 5, 9, 13, 17, 21, 25, 30 ]);
    });

    test('no tick count, 31 items', () {
      final data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 ];
      final rst = catAuto(
        data: data,
        isRounding: true,
      );
      expect(rst.ticks, [ 1, 6, 11, 16, 21, 26, 31 ]);
    });

    test('tick count 2, 5 items', () {
      final data = [ 1, 2, 3, 4, 5 ];
      final rst = catAuto(
        data: data,
        maxCount: 2,
      );
      expect(rst.ticks, [ 1, 5 ]);
    });

    test('tick count 3, 5 items', () {
      final data = [ 1, 2, 3, 4, 5 ];
      final rst = catAuto(
        data: data,
        maxCount: 3,
      );
      expect(rst.ticks, [ 1, 3, 5 ]);
    });

    test('array data', () {
      final data = [
        [ 1, 2, 3 ],
        [ 4, 5 ],
      ];
      final rst = catAuto(
        data: data,
        maxCount: 3,
      );
      expect(rst.ticks, [ 1, 3, 5 ]);
    });
  });
}
