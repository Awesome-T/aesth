void _mix(Map<String, Object> dist, Map<String, Object> src) {
  for (final key in src.keys) {
    if(src[key] != null) {
      dist[key] = src[key];
    }
  }
}

Map<String, Object> mix(List<Map<String, Object>> maps) {
  final rst = maps[0];
  for (var i = 1; i < maps.length; i++) {
    _mix(rst, maps[i]);
  }
  return rst;
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

Map<String, Object> deepMix(List<Map<String, Object>> maps) {
  final rst = maps[0];
  for (var i = 1; i < maps.length; i++) {
    _deepMix(rst, maps[i]);
  }
  return rst;
}

List<List<Map<String, Object>>> group(
  List<Map<String, Object>> data,
  [List<String> fields,
  Map<String, List<Object>> appendConditions = const <String, List<Object>>{}]
) {
  if (fields == null) {
    return [data];
  }
  final groups = groupToMap(data, fields);
  final array = <List<Map<String, Object>>>[];
  if (fields?.length == 1 && (appendConditions[fields[0]] != null)) {
    final values = appendConditions[fields[0]];
    values.forEach((value) {
      value = '_' + value.toString();
      array.add(groups[value]);
    });
  } else {
    for (var i in groups.keys) {
      array.add(groups[i]);
    }
  }

  return array;
}

Map<String, List<Map<String, Object>>> groupToMap(List<Map<String, Object>> data, [List<String> fields]) {
  if (fields == null) {
    return {
      '0': data,
    };
  }

  final callback = (Map<String, Object> row) {
    var unique = '_';
    for (var i = 0, l = fields.length; i < l; i++) {
      unique += row[fields[i]]?.toString();
    }
    return unique;
  };

  final groups = <String, List<Map<String, Object>>>{};
  for (var i = 0, len = data.length; i < len; i++) {
    final row = data[i];
    final key = callback(row);
    if (groups[key] != null) {
      groups[key].add(row);
    } else {
      groups[key] = [row];
    }
  }

  return groups;
}

List<T> merge<T>(List<List<T>> dataArray) {
  final rst = <T>[];
  for (var i = 0, len = dataArray.length; i < len; i++) {
    rst.addAll(dataArray[i]);
  }
  return rst;
}
