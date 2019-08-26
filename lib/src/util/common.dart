List<T> parseQuartet<T>(Object value) {
  T top;
  T right;
  T bottom;
  T left;

  if (value is T) {
    top = value;
    right = value;
    bottom = value;
    left = value;
  } else if (value is List<T>) {
    final l = value.length;
    switch (l) {
      case 0:
        break;
      case 1:
        top = value[0];
        right = value[0];
        bottom = value[0];
        left = value[0];
        break;
      case 2:
      case 3:
        top = value[0];
        right = value[1];
        bottom = value[0];
        left = value[1];
        break;
      default:
        top = value[0];
        right = value[1];
        bottom = value[2];
        left = value[3];
    }
  }
  return [top, right, bottom, left];
}