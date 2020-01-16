import 'package:flutter_test/flutter_test.dart';

import 'package:aesth/src/base.dart' show Base;

class BaseImpl extends Base {
  BaseImpl(Map<String, Object> cfg) : super(cfg);
}

main() {
  group('test base', () {
    test('init and get', () {
      final base = BaseImpl({
        'a': 'a',
        'b': 'b',
      });
      expect(base.get('a'), 'a');
      expect(base.get('b'), 'b');
      expect(base.get('c'), null);
    });

    test('set', () {
      final base = BaseImpl({
        'a': 'a',
        'b': 'b',
      });
      base.set('a', 'a1');
      base.set('c', 'c1');
      expect(base.get('a'), 'a1');
      expect(base.get('b'), 'b');
      expect(base.get('c'), 'c1');
    });

    test('destroy', () {
      final base = BaseImpl({
        'a': 'a',
        'b': 'b',
      });
      base.destroy();
      expect(base.get('a'), null);
      expect(base.get('b'), null);
      expect(base.get('c'), null);
      expect(base.destroyed, true);
    });
  });
}
