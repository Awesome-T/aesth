import 'package:aesth/src/scale/scale.dart';
import 'package:aesth/src/util/measures.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/time_cat_scale.dart' show TimeCatScale;
import 'package:intl/intl.dart';

main() {
  group('scale time cat', () {
    final mask = 'yyyy/MM/dd';
    final scale = TimeCatScale(
      values: [ 1442937600000, 1441296000000, 1449849600000 ],
      mask: mask,
    );

    test('type', () {
      expect(scale.type, 'timeCat');
      expect(scale.isCategory, true);
    });

    test('isRounding', () {
      expect(scale.isRouding, true);
    });

    test('cfg', () {
      expect(scale.values, isNotNull);
      expect(scale.type, 'timeCat');
      expect(scale.mask, 'yyyy/MM/dd');
    });

    test('translate', () {
      expect(scale.translate(1441296000000), 0);
      expect(scale.translate(1), 1);
      expect(scale.translate('2015/10/06').toString(), 'NaN');
      expect(scale.translate(3).toString(), 'NaN');
    });

    test('scale', () {
      expect(scale.scale(1441296000000), 0);
      expect(scale.scale(2), 1);
      expect(scale.scale('2015/10/06'), isNaN);
    });

    test('invert', () {
      expect(scale.invert(0), 1441296000000);
      expect(scale.invert(0.5), 1442937600000);
      expect(scale.invert(1), 1449849600000);
    });

    test('get text', () {
      final text = scale.getText(1441296000000);
      final date = DateTime.fromMillisecondsSinceEpoch(1441296000000);
      final dateFormat = DateFormat(mask);
      expect(text, dateFormat.format(date));
      expect(scale.getText(1), dateFormat.format(DateTime.fromMillisecondsSinceEpoch(1442937600000)));
    });

    test('this.ticks', () {
      expect(scale.ticks.length, 3);
      expect(scale.ticks, [
        1441296000000,
        1442937600000,
        1449849600000,
      ]);
    });

    test('getTicks', () {
      final ticks = scale.getTicks();
      expect(ticks[0] is TickObj, true);
      expect(ticks[1].value, 0.5);
      final dateFormat = DateFormat(mask);
      expect(ticks[1].text, dateFormat.format(DateTime.fromMillisecondsSinceEpoch(1442937600000)));
    });

    test('change', () {
      scale.change({
        'range': Range(0.2, 0.8),
        'values': [ 1442937600000, 1441296000000, 1449849600000, 1359648000000, 1362326400000, 1443024000000 ],
      });
      expect(scale.invert(scale.scale(1442937600000)), 1442937600000);
    });

    test('change with itcks', () {
      scale.change({
        'range': Range(0, 1),
        'ticks': [ 1442937600000, 1443024000000 ],
        'values': [ 1442937600000, 1441296000000, 1449849600000, 1359648000000, 1362326400000, 1443024000000 ],
      });
      expect(scale.getTicks().length, 2);
    });

    test('scale formatter', () {
      final scale = TimeCatScale(
        values: [ 1519084800000, 1519171200000, 1519257600000 ],
        mask: mask,
        formatter: (val) => 'time is ' + val.toString(),
        sortable: false
      );
      final text = scale.getText(1519084800000);
      expect(text, 'time is 1519084800000');
    });

    test('scale scale a value not in scale values', () {
      final scale = TimeCatScale(
        values: [ 1519084800000, 1519171200000, 1519257600000 ],
      );
      final scaledValue = scale.scale(1441296000000);
      expect(scaledValue, isNaN);
    });
  });
}
