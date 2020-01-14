import 'package:aesth/src/util/common.dart' show deepMix;
import './theme.dart' show Theme;

final Global = deepMix([{
  'scales': {},
  'widthRatio': {
    'column': 1 / 2,
    'rose': 0.999999,
    'multiplePie': 3 / 4,
  },
  'lineDash': [ 4, 4 ],
  'setTheme': (Map<String, Object> theme) {
    deepMix([Global, theme]);
  },
}, Theme]);

