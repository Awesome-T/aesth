import 'package:aesth/src/util/measures.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/scale/linear_scale.dart' show LinearScale;

main() {
  group('scale linear', () {
    final scale = LinearScale(
      min: 0,
      max: 100,
      formatter: (val) => '${val}元',
    );

    test('type', () {
      expect(scale.type, 'linear');
      expect(scale.isLinear, true);
    });

    test('cfg', () {
      expect(scale.min, 0);
      expect(scale.max, 100);
      expect(scale.type, 'linear');
    });

    test('translate', () {
      expect(scale.translate(50), 50);
    });

    test('scale', () {
      final val = scale.scale(50);
      expect(val, 0.5);
      expect(scale.scale(0), 0);
      expect(scale.scale(100), 1);
    });

    test('invert', () {
      expect(scale.invert(0), 0);
      expect(scale.invert(0.5), 50);
      expect(scale.invert(1), 100);
    });

    test('formatter', () {
      expect(scale.getText(5), '5元');
    });

    test('ticks', () {
      final ticks = scale.getTicks();
      expect(ticks.length, isNot(0));
      expect(ticks[0].value, 0);
      expect(ticks.last.value, 1);
    });

    test('clone', () {
      final n1 = scale.clone();
      expect(n1.scale(0), 0);
      expect(n1.scale(100), 1);
      expect(n1.type, 'linear');
    });

    test('scale null', () {
      expect(scale.scale(null).isNaN, true);
    });

    test('change', () {
      scale.min = 10;
      scale.max = 110;
      scale.change();
      expect(scale.scale(60), 0.5);
    });
  });

  group('scale linear change range', () {
    final scale = LinearScale(
      min: 0,
      max: 100,
      range: Range(0, 1000),
    );

    test('cfg', () {
      expect(scale.range, isNot(null));
      expect(scale.range.min, 0);
      expect(scale.range.max, 1000);
    });

    test('scale', () {
      final val = scale.scale(50);
      expect(val, 500);
      expect(scale.scale(0), 0);
      expect(scale.scale(100), 1000);
    });

    test('invert', () {
      expect(scale.invert(0), 0);
      expect(scale.invert(500), 50);
      expect(scale.invert(1000), 100);
    });
  });

  group('scale not nice', () {
    final scale = LinearScale(
      min: 3,
      max: 97,
    );

    test('cfg', () {
      expect(scale.min, 3);
      expect(scale.max, 97);
    });

    test('scale', () {
      final val = scale.scale(50);
      expect(val, (50 - 3) / (97 - 3));
    });

    test('invert', () {
      expect(scale.invert(0), 3);
      expect(scale.invert(1), 97);
    });

    test('ticks', () {
      final ticks = scale.getTicks();
      expect(double.parse(ticks[0].text) > 3, true);
      expect(double.parse(ticks.last.text) < 97, true);
    });
  });

  group('scale nice', () {
    final scale = LinearScale(
      min: 3,
      max: 97,
      nice: true,
    );

    test('cfg', () {
      expect(scale.min, isNot(3));
      expect(scale.max, isNot(97));
    });

    test('scale', () {
      final val = scale.scale(50);
      expect(val, 0.5);
    });

    test('invert', () {
      expect(scale.invert(0), 0);
      expect(scale.invert(1), 100);
    });

    test('ticks', () {
      final ticks = scale.getTicks();
      expect(double.parse(ticks[0].text) < 3, true);
      expect(double.parse(ticks.last.text) > 97, true);
    });

    test('clone', () {
      final s1 = scale.clone();
      expect(s1.invert(0), 0);
    });
  });

  group('scale ticks', () {
    final scale = LinearScale(
      ticks: [ 1, 2, 3, 4, 5 ],
    );

    test('min, max', () {
      expect(scale.min, 1);
      expect(scale.max, 5);
    });
  });

  group('scale linear: min is equal to max', () {
    final scale = LinearScale(
      min: 0,
      max: 0,
      nice: false,
    );

    test('scale', () {
      final val = scale.scale(0);
      expect(val, 0);
    });

    test('invert', () {
      expect(scale.invert(1), 0);
      expect(scale.invert(0), 0);
    });
  });

  group('scale linear: min is equal to max, nice true', () {
    final scale = LinearScale(
      min: 0,
      max: 0,
      nice: true,
    );

    test('scale', () {
      final val = scale.scale(0);
      expect(val, 0);
    });

    test('invert', () {
      expect(scale.invert(1), 1);
      expect(scale.invert(0), 0);
    });
  });

  group('scale linear: declare tickInterval.', () {
    final scale = LinearScale(
      min: 20,
      max: 85,
      tickInterval: 15,
      nice: true,
    );

    test('ticks', () {
      final ticks = scale.ticks;
      expect(ticks.length, 6);
      expect(ticks, [ 15, 30, 45, 60, 75, 90 ]);
    });
  });
}