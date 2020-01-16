import 'dart:math' show pi;

import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/graphic/util/matrix.dart' show Matrix, TransAction, TransActionType;
import 'package:aesth/src/graphic/util/vector2.dart' show Vector2;

main() {
  group('Matrix Util', () {
    
    test('multiply', () {
      final m1 = Matrix(1, 100, 0, 1, 100, 1);
      final m2 = Matrix(2, 2, 2, 2, 2, 2);
      m1.multiply(m2);
      expect(m1, Matrix(2, 202, 2, 202, 102, 203));
    });

    test('scale', () {
      final m = Matrix(1, 0, 0, 1, 0, 0);
      final v = Vector2(0.1, 1.4);
      m.scale(v);
      expect(m, Matrix(0.1, 0, 0, 1.4, 0, 0));
    });

    test('rotate', () {
      final m = Matrix(1, 0, 0, 1, 0, 0);
      final radian = pi;
      m.rotate(radian);
      expect(m, Matrix(-1, 1.2246467991473532e-16, -1.2246467991473532e-16, -1, 0, 0));
    });

    test('translate', () {
      final m = Matrix(1, 0, 0, 1, 0, 0);
      final v = Vector2(10, 20);
      m.translate(v);
      expect(m, Matrix(1, 0, 0, 1, 10, 20));
    });

    test('transform', () {
      final m = Matrix(1, 0, 0, 1, 0, 0);
      m.transform([
        TransAction(TransActionType.translate, Vector2(10, 10)),
        TransAction(TransActionType.scale, Vector2(100, 1)),
        TransAction(TransActionType.rotate, pi / 4),
        TransAction(TransActionType.translate, Vector2(-10, -10)),
      ]);
      expect(m, Matrix(70.71067811865476, 0.7071067811865476, -70.71067811865476, 0.7071067811865476, 10.0, -4.142135623730951));
    });
  });
}
