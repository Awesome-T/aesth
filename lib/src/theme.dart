import 'dart:ui';

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
