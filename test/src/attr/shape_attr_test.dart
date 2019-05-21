import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/attr/shape_attr.dart' show ShapeAttr;
import 'package:aesth/src/scale/cat_scale.dart' show CatScale;
import 'package:aesth/src/scale/linear_scale.dart' show LinearScale;

main() {
  group('attr test shape', () {
    final scaleCat = CatScale(
      field: 'type',
      values: [ 'a', 'b', 'c', 'd' ],
    );

    final scaleLinear = LinearScale(
      field: 'age',
      min: 0,
      max: 10,
    );

    test('init', () {
      final shape = ShapeAttr();
      expect(shape.type, 'shape');
      expect(shape.getNames().length, 0);
    });

    test('test category mapping', () {
      final shape = ShapeAttr(
        scales: [ scaleCat ],
        values: [ 's1', 's2' ],
      );
      expect(shape.mapping(['a'])[0], 's1');
      expect(shape.mapping(['b'])[0], 's2');
      expect(shape.mapping(['c'])[0], 's1');
      expect(shape.mapping(['d'])[0], 's2');
    });

    test('test linear mapping', () {
      final shape = ShapeAttr(
        scales: [ scaleLinear ],
        values: [ 's1', 's2' ],
      );
      expect(shape.mapping([0])[0], 's1');
      expect(shape.mapping([4])[0], 's1');
      expect(shape.mapping([9])[0], 's2');
      expect(shape.mapping([10])[0], 's2');
    });
  });
}
