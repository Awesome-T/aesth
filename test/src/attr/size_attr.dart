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
    });
  });
}
