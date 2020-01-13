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

void _deepMix(Map<String, Object> dist, Map<String, Object> src, [int level = 0]) {
  const maxLevel = 5;
  for (final key in src.keys) {
    final value = src[key];
    if (value is Map<String, Object>) {
      if (!(dist[key] is Map<String, Object>)) {
        dist[key] = <String, Object>{};
      }
      if (level < maxLevel) {
        _deepMix(dist[key], value, level + 1);
      } else {
        dist[key] = src[key];
      }
    } else if(value is List) {
      dist[key] = [...value];
    } else if(value != null) {
      dist[key] = value;
    }
  }
}

void deepMixin(List<Map<String, Object>> maps) {
  final rst = maps[0];
  for (var i = 1; i < maps.length; i++) {
    _deepMix(rst, maps[i]);
  }
}
