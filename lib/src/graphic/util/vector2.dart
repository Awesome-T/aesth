import 'dart:math' as math;

import 'package:vector_math/vector_math.dart' as vector_math show Vector2 ;

import 'matrix.dart' show Matrix;

class Vector2 extends vector_math.Vector2 {
  Vector2.create() : super.zero();

  /// Set the values of [result] to the minimum of [a] and [b] for each line.
  static void min(Vector2 a, Vector2 b, Vector2 result) {
    result
      ..x = math.min(a.x, b.x)
      ..y = math.min(a.y, b.y);
  }

  /// Set the values of [result] to the maximum of [a] and [b] for each line.
  static void max(Vector2 a, Vector2 b, Vector2 result) {
    result
      ..x = math.max(a.x, b.x)
      ..y = math.max(a.y, b.y);
  }

  /// Interpolate between [min] and [max] with the amount of [a] using a linear
  /// interpolation and store the values in [result].
  static void mix(Vector2 min, Vector2 max, double a, Vector2 result) {
    result
      ..x = min.x + a * (max.x - min.x)
      ..y = min.y + a * (max.y - min.y);
  }

  void transformMat2d(Matrix m) {

    final x = this[0];
    final y = this[1];
    this[0] = m[0] * x + m[2] * y + m[4];
    this[1] = m[1] * x + m[3] * y + m[5];
  }
}
