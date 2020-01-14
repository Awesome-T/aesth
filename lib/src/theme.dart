import 'dart:ui';
import 'package:aesth/src/util/common.dart' show mix;

const color1 = Color(0xffe8e8e8); // color of axis-line and axis-grid
const color2 = Color(0xff808080); // color of axis label

const defaultAxis = {
  'label': {
    'fill': color2,
    'fontSize': 10,
  },
  'line': {
    'stroke': color1,
    'lineWidth': 1,
  },
  'grid': {
    'type': 'line',
    'stroke': color1,
    'lineWidth': 1,
    'lineDash': [ 2 ],
  },
  'tickLine': null,
  'labelOffset': 7.5,
};

final Theme = {
  'fontFamily': '"Helvetica Neue", "San Francisco", Helvetica, Tahoma, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", sans-serif',
  'defaultColor': Color(0xff1890FF),
  'pixelRatio': 1,
  'padding': 'auto',
  'appendPadding': 15,
  'colors': [
    Color(0xff1890FF),
    Color(0xff2FC25B),
    Color(0xffFACC14),
    Color(0xff223273),
    Color(0xff8543E0),
    Color(0xff13C2C2),
    Color(0xff3436C7),
    Color(0xffF04864),
  ],
  'shapes': {
    'line': [ 'line', 'dash' ],
    'point': [ 'circle', 'hollowCircle' ]
  },
  'sizes': [ 4, 10 ],
  'axis': {
    'common': defaultAxis, // common axis configuration
    'bottom': mix([{}, defaultAxis, {
      'grid': null
    }]),
    'left': mix([{}, defaultAxis, {
      'line': null
    }]),
    'right': mix([{}, defaultAxis, {
      'line': null
    }]),
    'circle': mix([{}, defaultAxis, {
      'line': null
    }]),
    'radius': mix([{}, defaultAxis, {
      'labelOffset': 4
    }]),
  },
  'shape': {
    'line': {
      'lineWidth': 2,
      'lineJoin': 'round',
      'lineCap': 'round'
    },
    'point': {
      'lineWidth': 0,
      'size': 3
    },
    'area': {
      'fillOpacity': 0.1
    }
  },
  '_defaultAxis': defaultAxis
};
