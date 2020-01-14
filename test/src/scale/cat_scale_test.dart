import 'package:aesth/src/util/api.dart' show Range;
import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/cat_scale.dart' show CatScale;

main() {
  group('scale', () {
    final scale = CatScale(
      values: [ '一月', '二月', '三月', '四月', '五月' ],
    );

    test('type', () {
      expect(scale.type, 'cat');
      expect(scale.isCategory, true);
    });

    test('isRounding', () {
      expect(scale.isRouding, true);
    });

    test('cfg', () {
      expect(scale.values, isNotNull);
      expect(scale.type, 'cat');
    });

    test('translate', () {
      expect(scale.translate('二月'), 1);
      expect(scale.translate(1), 1);
      expect(scale.translate('test'), isNaN);
    });

    test('scale', () {
      final val = scale.scale('二月');
      expect(val, 0.25);
      expect(scale.scale(0), 0);
      expect(scale.scale(4), 1);
    });

    test('get text', () {
      expect(scale.getText('二月'), '二月');
      expect(scale.getText(1), '二月');
    });

    test('invert', () {
      expect(scale.invert(0), '一月');
      expect(scale.invert(0.5), '三月');
      expect(scale.invert(1), '五月');
      expect(scale.invert('二月'), '二月');
      expect(scale.invert(-1), '一月');
      expect(scale.invert(2), '五月');
    });

    test('ticks', () {
      final ticks = scale.getTicks();
      expect(ticks.length, scale.values.length);
      expect(ticks[0].value, 0);
      expect(ticks.last.value, 1);
    });

    test('clone', () {
      final n1 = scale.clone();
      expect(n1.scale(0), 0);
      expect(n1.scale(2), 0.5);
      expect(n1.scale(4), 1);

      expect(scale.invert(0), '一月');
      expect(scale.invert(0.5), '三月');
      expect(scale.invert(1), '五月');

      expect(n1.type, 'cat');
    });

    test('change', () {
      scale.change({
        'values': [ '一', '二', '三', '四', '五', '六' ],
      });
      expect(scale.invert(0), '一');
      expect(scale.invert(0.4), '三');
      expect(scale.invert(1), '六');

      expect(scale.getTicks().length, 6);
    });

    /// scale.values keeps in type of F
  });

  group('scale cat change range', () {
    final scale = CatScale(
      values: [ '一月', '二月', '三月', '四月', '五月' ],
      range: Range(0.1, 0.9),
    );

    test('cfg', () {
      expect(scale.range, isNotNull);
      expect(scale.range.min, 0.1);
      expect(scale.range.max, 0.9);
    });

    test('scale', () {
      final val = scale.scale('二月');
      expect(double.parse(val.toStringAsFixed(1)), 0.3);
      expect(scale.scale(0), 0.1);
      expect(scale.scale(4), 0.9);

      expect(scale.scale('一月'), 0.1);
      expect(scale.scale('五月'), 0.9);
    });

    test('invert', () {
      expect(scale.invert(0.1), '一月');
      expect(scale.invert(0.5), '三月');
      expect(scale.invert(0.9), '五月');
    });
  });

  group('scale cat with tick count', () {
    final values = [];
    for (var i = 0; i < 100; i++) {
      values.add(i);
    }
    final scale = CatScale(
      values: values,
      tickCount: 10,
    );

    test('cfg', () {
      expect(scale.values.length, 100);
      expect(scale.ticks.length, isNot(100));
    });

    test('ticks', () {
      final ticks = scale.getTicks();
      expect(ticks.length, 10);
      expect(ticks[0].value, 0);
      expect(ticks.last.value, 1);
    });
  });
}