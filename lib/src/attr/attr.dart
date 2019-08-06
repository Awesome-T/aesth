import 'dart:math' as math;

import 'package:aesth/src/base.dart';
import 'package:aesth/src/scale/scale.dart';

Object _toScaleString<F>(Scale<F> scale, F value) {
  if (value is String) {
    return value;
  }
  return scale.invert(scale.scale(value));
}

typedef AttrCallback = Object Function(List<Object> params);

typedef AttrGradient<V> = V Function(num percent);

abstract class Attr<V> extends FieldAttachable {
  Attr({
    String field,
    List<String> fieldList,

    this.values,
    V value,
    AttrCallback callback,
    this.scales,
    this.gradient,
    this.linear = false,
  }) : super(
    field: field,
    fieldList: fieldList,
  ) {
    this.values ??= [value];
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

    this.callback = (mixedCallback != null) ? mixedCallback : this._defaultCallback;
  }

  final type = 'base';

  final names = <String>[];

  set value(V value) => values ??= [value];

  List<V> values;

  List<Scale> scales;

  bool linear;

  AttrCallback callback;

  AttrGradient<V> gradient;

  V _getAttrValue<F>(Scale<F> scale, F value) {
    final values = this.values;
    if (scale.isCategory && !this.linear) {
      final index = scale.translate(value);
      return values[index % values.length];
    }
    final percent = scale.scale(value);
    return this.getLinearValue(percent);
  }

  V getLinearValue(num percent) {
    final values = this.values;
    final steps = values.length -1;
    final step = (steps * percent).floor();
    final leftPercent = steps * percent - step;
    final start = values[step] as num;
    final end = (step == steps) ? start : (values[step + 1] as num);
    final rstValue = start + (end - start) * leftPercent;
    return rstValue as V;
  }

  V _defaultCallback<F>(List<F> params) {
    final scale = this.scales[0];
    final rstValue = this._getAttrValue(scale, params[0]);
    return rstValue;
  }

  List<String> getNames() {
    final scales = this.scales ?? [];
    final names = this.names ?? [];
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

  List mapping(List params) {
    final scales = this.scales;
    final callback = this.callback;
    if (callback != null) {
      final originParams = [];
      for (var i = 0, len = params.length; i < len; i++) {
        originParams.add(this._toOriginParam(params[i], scales[i]));
      }
      final values = this.callback(originParams);
      return values is List ? values : [values];
    } else {
      return List<V>.from(params);
    }
  }

  Object _toOriginParam<F>(Object param, Scale<F> scale) {
    if (!scale.isLinear) {
      var rst;
      if (param is List<F>) {
        rst = [];
        for (var i = 0, len = param.length; i < len; i++) {
          rst.add(_toScaleString(scale, param[i]));
        }
      } else {
        rst = _toScaleString(scale, param);
      }
      return rst;
    }
    return param;
  }
}