List splitArray(List<Map<String, Object>> data, String yField, bool connectNulls) {
  if (data.isEmpty) {
    return [];
  }
  final arr = [];
  var tmp = [];
  Object yValue;
  data.forEach((obj) {
    yValue = obj['_origin'] ? (obj['_origin'] as Map)[yField] : obj[yField];
    if (connectNulls) {
      if (yValue != null) {
        tmp.add(obj);
      }
    } else {
      if ((yValue is List && (yValue as List)[0] == null) || yValue == null) {
        if (tmp.isNotEmpty) {
          arr.add(tmp);
          tmp = [];
        }
      } else {
        tmp.add(obj);
      }
    }
  });

  if (tmp.isNotEmpty) {
    arr.add(tmp);
  }

  return arr;
}
