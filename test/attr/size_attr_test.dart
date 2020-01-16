import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/attr/size_attr.dart' show SizeAttr;
import 'package:aesth/src/scale/cat_scale.dart' show CatScale;
import 'package:aesth/src/scale/linear_scale.dart' show LinearScale;

main() {
  group('attr test size', () {
    final scaleCat = CatScale(
      field: 'type',
      values: [ 'a', 'b', 'c', 'd' ],
    );

    final scaleLinear = LinearScale(
      field: 'age',
      min: 0,
      max: 10,
    );

    test('mapping size two size', () {
      final size = SizeAttr(
        scales: [ scaleLinear ],
        values: [ 0, 100 ],
      );
      expect(size.type, 'size');
      expect(size.mapping([0])[0], 0);
      expect(size.mapping([10])[0], 100);
      expect(size.mapping([5])[0], 50);
    });

    test('mapping size three size', () {
      final size = SizeAttr(
        scales: [ scaleLinear ],
        values: [ 0, 10, 100 ],
      );
      expect(size.mapping([0])[0], 0);
      expect(size.mapping([10])[0], 100);
      expect(size.mapping([4])[0], 8);
      expect(size.mapping([8])[0], 64);
    });

    test('mapping size category', () {
      final size = SizeAttr(
        scales: [ scaleCat ],
        values: [ 0, 10, 100 ],
      );
      expect(size.mapping(['a'])[0], 0);
      expect(size.mapping(['b'])[0], 10);
      expect(size.mapping(['c'])[0], 100);
    });
  });
}
