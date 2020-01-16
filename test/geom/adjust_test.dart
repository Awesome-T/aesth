import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart' show groupBy;

import 'package:aesth/src/geom/adjust/stack.dart' show Stack;
import 'package:aesth/src/geom/adjust/dodge.dart' show Dodge;

main() {
  group('stack adjust', () {
    group('default stack', () {
      final data = [
        {'a': 1, 'b': 2, 'c': 1},
        {'a': 1, 'b': 3, 'c': 2},
        {'a': 2, 'b': 1, 'c': 1},
        {'a': 2, 'b': 4, 'c': 2},
        {'a': 3, 'b': 5, 'c': 1},
        {'a': 3, 'b': 1, 'c': 2},
      ];

      final adjust = Stack(
        xField: 'a',
        yField: 'b',
      );

      test('init', () {
        expect(adjust.xField, 'a');
        expect(adjust.yField, 'b');
      });

      test('process adjust', () {
        final rst = adjust.processAdjust([data]);

        final obj1 = rst[0][0];
        expect((obj1['b'] as List<num>).length, 2);
        expect((obj1['b'] as List<num>)[0], 0);
        expect((obj1['b'] as List<num>)[1], 2);

        final obj2 = rst[0][1];
        expect((obj2['b'] as List<num>)[0], 2);
        expect((obj2['b'] as List<num>)[1], 5);
      });
    });

    group('stack array', () {
      final data = [
        {'a': 1, 'b': [0, 3], 'c': 1},
        {'a': 1, 'b': [3, 4], 'c': 2},
        {'a': 2, 'b': 1, 'c': 1},
        {'a': 2, 'b': 4, 'c': 2},
        {'a': 3, 'b': 5, 'c': 1},
        {'a': 3, 'b': 1, 'c': 2},
      ];

      final adjust = Stack(
        xField: 'a',
        yField: 'b',
      );

      test('process adjust', () {
        final rst = adjust.processAdjust([data]);

        final obj1 = rst[0][0];
        expect((obj1['b'] as List<num>).length, 2);
        expect((obj1['b'] as List<num>)[0], 0);
        expect((obj1['b'] as List<num>)[1], 3);

        final obj2 = rst[0][1];
        expect((obj2['b'] as List<num>)[0], 3);
        expect((obj2['b'] as List<num>)[1], 7);
      });
    });

    group('stack with 0', () {
      final data = [
        {'a': 1, 'b': 2, 'c': 1},
        {'a': 1, 'b': 0, 'c': 2},
        {'a': 2, 'b': 1, 'c': 1},
        {'a': 2, 'b': 4, 'c': 2},
        {'a': 3, 'b': 0, 'c': 1},
        {'a': 3, 'b': 1, 'c': 2},
      ];

      final adjust = Stack(
        xField: 'a',
        yField: 'b',
      );

      test('process adjust', () {
        final rst = adjust.processAdjust([data]);

        final obj1 = rst[0][0];
        expect((obj1['b'] as List<num>).length, 2);
        expect((obj1['b'] as List<num>)[0], 0);
        expect((obj1['b'] as List<num>)[1], 2);

        final obj2 = rst[0][1];
        expect((obj2['b'] as List<num>).length, 2);
        expect((obj2['b'] as List<num>)[0], 2);
        expect((obj2['b'] as List<num>)[1], 2);
      });
    });
  });

  group('adjust dodge', () {
    group('default adjust all has two', () {
      final data = [
        {'a': 1, 'b': 2, 'c': 1},
        {'a': 1, 'b': 3, 'c': 2},
        {'a': 2, 'b': 1, 'c': 1},
        {'a': 2, 'b': 4, 'c': 2},
        {'a': 3, 'b': 5, 'c': 1},
        {'a': 3, 'b': 1, 'c': 2},
      ];

      final groupData = groupBy(data, (obj) => obj['c']).values.toList();

      final adjust = Dodge(
        xField: 'a',
        marginRatio: 0.5,
      );

      test('init', () {
        expect(adjust.xField, 'a');
      });

      test('process adjust', () {
        final rst = adjust.processAdjust(groupData);
        expect(rst.length, 2);

        final d1 = rst[0];

        final obj1 = d1[0];
        expect(obj1['a'], 0.8125);

        final obj2 = d1[1];
        expect(obj2['a'], 1.8125);
      });
    });

    group('adjust only one group.', () {
      final data = [
        {'a': 0, 'b': 1, 'c': 2},
        {'a': 1, 'b': 1, 'c': 1},
        {'a': 2, 'b': 1, 'c': 1},
      ];

      final adjust = Dodge(
        xField: 'a',
      );
      final groupData = groupBy(data, (obj) => obj['b']).values.toList();

      test('adjust', () {
        final rst = adjust.processAdjust(groupData);
        expect(rst[0][0]['a'], 0);
        expect(rst[0][1]['a'], 1);
        expect(rst[0][2]['a'], 2);
      });
    });
  });
}
