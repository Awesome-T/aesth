/// Position operation related.

class Range {
  const Range(this.min, this.max);

  final double min;

  final double max;
}

/// Modes.

enum AlignMode {
  start,
  center,
  end,
}

enum SelectedMode {
  multiple,
  single,
}

// https://flutter.dev/docs/development/ui/advanced/gestures
enum GestureMode {
  tapDown,
  tapUp,
  tap,
  tapCancel,

  doubleTap,

  longPress,

  dragStart,
  dragUpdate,
  dragEnd,

  verticalDragStart,
  verticalDragUpdate,
  verticalDragEnd,

  horizontalDragStart,
  horizontalDragUpdate,
  horizontalDragEnd,

  panStart,
  panUpdate,
  panEnd,
}
