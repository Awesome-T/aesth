import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/attr/color_attr.dart' show ColorAttr;
import 'package:aesth/src/scale/cat_scale.dart' show CatScale;
import 'package:aesth/src/scale/linear_scale.dart' show LinearScale;

main() {
  group('default gradient', () {
    test('gradient white black', () {
      final gradient = ColorAttr(values: [
        Color(0xffffffff),
        Color(0xff000000),
      ]).getLinearValue;
      expect(gradient(0), Color(0xffffffff));
      expect(gradient(1), Color(0xff000000));
      expect(gradient(0.5), Color(0xff7f7f7f));
    });

    test('gradient red blue', () {
      final gradient = ColorAttr(values: [
        Color(0xffff0000),
        Color(0xff0000ff),
      ]).getLinearValue;
      expect(gradient(0), Color(0xffff0000));
      expect(gradient(-0.1), Color(0xffff0000));
      expect(gradient(1), Color(0xff0000ff));
      expect(gradient(1.2), Color(0xff0000ff));
      expect(gradient(0.5), Color(0xff7f007f));
    });
  });

  group('attr test color', () {
    final scaleCat = CatScale(
      field: 'type',
      values: [ 'a', 'b', 'c', 'd' ],
    );

    final scaleLinear = LinearScale(
      field: 'age',
      min: 0,
      max: 10,
    );

    group('no callback category', () {
      final color = ColorAttr(
        scales: [ scaleCat, scaleLinear ],
        values: [ Colors.amberAccent, Colors.blueAccent, Colors.cyanAccent ],
      );

      test('init', () {
        expect(color.type, 'color');
        expect(color.getNames(), ['color']);
      });

      test('mapping', () {
        expect(color.mapping(['a'])[0], Colors.amberAccent);
        expect(color.mapping(['b'])[0], Colors.blueAccent);
        expect(color.mapping(['c'])[0], Colors.cyanAccent);
        expect(color.mapping(['d'])[0], Colors.amberAccent);
      });
    });

    group('no callback linear', () {
      final color = ColorAttr(
        scales: [ scaleLinear ],
        values: [
          Color(0xff000000),
          Color(0xff0000ff),
          Color(0xff00ff00),
          Color(0xffff0000),
          Color(0xffffffff),
        ],
      );

      test('mapping', () {
        expect(color.mapping([0])[0], Color(0xff000000));
        expect(color.mapping([2.5])[0], Color(0xff0000ff));
        expect(color.mapping([5])[0], Color(0xff00ff00));
        expect(color.mapping([10])[0], Color(0xffffffff));
        expect(color.mapping([4])[0], Color(0xff009965));
      });
    });

    group('color gradient', () {
      final color = ColorAttr(
        scales: [ scaleCat ],
        values: [
          Color(0xff000000),
          Color(0xff0000ff),
        ],
        linear: true,
      );

      test('mapping', () {
        expect(color.mapping(['a'])[0], Color(0xff000000));
        expect(color.mapping(['b'])[0], Color(0xff000055));
        expect(color.mapping(['c'])[0], Color(0xff0000aa));
        expect(color.mapping(['d'])[0], Color(0xff0000ff));
      });

      test('single color', () {
        final color = ColorAttr(
          scales: [ scaleCat ],
          values: [
            Color(0xffff0000),
          ],
        );
        expect(color.mapping(['a'])[0], Color(0xffff0000));
        expect(color.mapping(['b'])[0], Color(0xffff0000));
        expect(color.mapping(['c'])[0], Color(0xffff0000));
        expect(color.mapping(['d'])[0], Color(0xffff0000));
      });
    });
  });
}
