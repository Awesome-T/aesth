import 'package:aesth/src/base.dart';
import 'package:aesth/src/scale/scale.dart';

typedef AttrCallback<F, V> = V Function(F fieldValue);

abstract class Attr<F, V> extends FieldAttachable {
  Attr({
    String field,
    List<String> fieldList,

    List<V> valueList,
    this.value,
    AttrCallback<F, V> callback,
    this.scales,
  })
    : values = valueList,
      super(
        field: field,
        fieldList: fieldList,
      ) {
    AttrCallback mixedCallback;
    final defaultCallback = this.callback;

    if (callback != null) {
      final userCallback = callback;
      mixedCallback = (value) {
        var ret = userCallback(value);
        if (ret == null) {
          ret = defaultCallback(value);
        }
        return ret;
      };
    }
  }

  final type = 'base';

  set valueList(List<V> valueList) => values = valueList;
  List<V> get valueList => values;

  V value;

  List<V> values;

  List<Scale<F>> scales;

  bool linear = false;

  V _getAttrValue(Scale<F> scale, F value) {
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

  V callback(F value) {
    final scale = this.scales[0];
    final rstValue = this._getAttrValue(scale, value);
    return rstValue;
  }
}