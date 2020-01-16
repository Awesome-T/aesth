import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/auto/util.dart' as util;

void main() {
  group('test util', () {
    test('snap to', () {
      final data = [ 1, 10, 15, 20, 22 ];
      expect(util.snapTo(data, 2), 1);
      expect(util.snapTo(data, 0), 1);
      expect(util.snapTo(data, 23), 22);
      expect(util.snapTo(data, 17), 15);
      expect(util.snapTo(data, 12.5), 15);
    });

    test('snap floor', () {
      final data = [ 1, 10, 15, 20, 22 ];
      expect(util.snapFloor(data, 2), 1);
      expect(util.snapFloor(data, 0).isNaN, true);
      expect(util.snapFloor(data, 23), 22);
      expect(util.snapFloor(data, 19), 15);
    });

    test('snapFactorTo', () {
      final data = [ 0, 1, 2, 5, 10 ];
      expect(util.snapFactorTo(1.2, data), 1);
      expect(util.snapFactorTo(1.2, data, util.SnapType.ceil), 2);
      expect(util.snapFactorTo(23, data), 20);
      expect(util.snapFactorTo(0, data), 0);
    });

    test('snap ceiling', () {
      final data = [ 1, 10, 15, 20, 22 ];
      expect(util.snapCeiling(data, 2), 10);
      expect(util.snapCeiling(data, 0), 1);
      expect(util.snapCeiling(data, 19), 20);
      expect(util.snapCeiling(data, 23).isNaN, true);
    });

    test('snap empty', () {
      expect(util.snapTo([], 10).isNaN, true);
      expect(util.snapCeiling([], 10).isNaN, true);
      expect(util.snapFloor([], 10).isNaN, true);
    });

    test('snap with factor', () {
      final arr = [ 0, 1, 2, 5, 10 ];
      expect(util.snapFactorTo(0.7, arr), 0.5);
      expect(util.snapFactorTo(7, arr), 5);
      expect(util.snapFactorTo(7.8, arr), 10);
    });

    test('snap with factor floor', () {
      final arr = [ 0, 1, 2, 5, 10 ];
      expect(util.snapFactorTo(0.7, arr, util.SnapType.floor), 0.5);
      expect(util.snapFactorTo(7, arr, util.SnapType.floor), 5);
      expect(util.snapFactorTo(7.8, arr, util.SnapType.floor), 5);
    });

    test('snap with factor ceil', () {
      final arr = [ 0, 1, 2, 5, 10 ];
      expect(util.snapFactorTo(0.7, arr, util.SnapType.ceil), 1);
      expect(util.snapFactorTo(7, arr, util.SnapType.ceil), 10);
      expect(util.snapFactorTo(7.8, arr, util.SnapType.ceil), 10);
    });

    test('snap multiple', () {
      expect(util.snapMultiple(23, 5, util.SnapType.floor), 20);
      expect(util.snapMultiple(23, 5, util.SnapType.ceil), 25);
      expect(util.snapMultiple(22, 5), 20);
      expect(util.snapMultiple(23, 5), 25);
    });
  });
}
