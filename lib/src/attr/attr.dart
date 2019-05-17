import 'dart:math' as math;
import 'dart:ui';

import 'package:aesth/src/base.dart';
import 'package:aesth/src/scale/scale.dart';

Object _toScaleString<F>(Scale<F> scale, F value) {
  if (value is String) {
    return value;
  }
  return scale.invert(scale.scale(value));
}

typedef AttrCallback = Object Function(List<Object> params);

abstract class Attr<V> extends FieldAttachable {
  Attr({
    String field,
    List<String> fieldList,

    this.values,
    this.value,
    AttrCallback callback,
    this.scales,
    this.gradient,
  }) : super(
    field: field,
    fieldList: fieldList,
  ) {
    var mixedCallback;
    final defaultCallback = this._defaultCallback;

    if (callback != null) {
      final userCallback = callback;
      mixedCallback = (List<Object> params) {
        V ret = userCallback(params);
        if (ret == null) {
          ret = defaultCallback(params[0]);
        }
        return ret;
      };
    }

    if (mixedCallback != null) {
      this.callback = mixedCallback;
    }
  }

  final type = 'base';

  final names = <String>[];

  V value;

  List<V> values;

  List<Scale> scales;

  bool linear = false;

  AttrCallback callback;

  Gradient gradient;

  V _getAttrValue<F>(Scale<F> scale, F value) {
    final values = this.values;
    if (scale.isCategory && !this.linear) {
      final index = scale.translate(value);
      return values[index % values.length];
    }
    final percent = scale.scale(value);
    return this.getLinearValue(percent) as V;
  }

  num getLinearValue(num percent) {
    final values = this.values;
    final steps = values.length -1;
    final step = (steps * percent).floor();
    final leftPercent = steps * percent - step;
    final start = values[step] as num;
    final end = (step == steps) ? start : (values[step + 1] as num);
    final rstValue = start + (end - start) * leftPercent;
    return rstValue;
  }

  V _defaultCallback<F>(F value) {
    final scale = this.scales[0];
    final rstValue = this._getAttrValue(scale, value);
    return rstValue;
  }

  List<String> getNames() {
    final scales = this.scales;
    final names = this.names;
    final length = math.min(scales.length, names.length);
    final rst = <String>[];
    for (var i = 0; i < length; i++) {
      rst.add(names[i]);
    }
    return rst;
  }

  List<String> getFields() {
    final scales = this.scales;
    final rst = [];
    scales?.forEach((scale) {
      rst.add(scale.field);
    });
    return rst;
  }

  Scale getScale(String name) {
    final scales = this.scales;
    final names = this.names;
    final index = names.indexOf(name);
    return scales[index];
  }

  List<V> mapping(List<Object> params) {
    final scales = this.scales;
    final callback = this.callback;
    final originParam = [];
    if (callback != null) {
      for (var i = 0, len = params.length; i < len; i++) {
        originParam[i] = this._toOriginParam(params[i], scales[i]);
      }
      final values = this.callback(params);
      return values is List ? values : [values];
    } else {
      return params;
    }
  }

  List _toOriginParam<F>(Object param, Scale<F> scale) {
    var rst;
    if (!scale.isLinear) {
      if (param is List<F>) {
        rst = [];
        for (var i = 0, len = param.length; i < len; i++) {
          rst.add(_toScaleString(scale, param[i]));
        }
      } else {
        rst = _toScaleString(scale, param);
      }
    }
    return rst;
  }
}