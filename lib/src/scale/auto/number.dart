import 'dart:math' as math;

import './util.dart' as auto_util;

const _minCount = 5;
const _maxCount = 7;
const _snapCountArray = [ 0, 1, 1.2, 1.5, 1.6, 2, 2.2, 2.4, 2.5, 3, 4, 5, 6, 7.5, 8, 10 ];
const _snapArray = [ 0, 1, 2, 4, 5, 10 ];

class NumberAutoRst {
  NumberAutoRst(
    this.min,
    this.max,
    this.interval,
    this.count,
    this.ticks,
  );

  final num min;
  final num max;
  final num interval;
  final int count;
  final List<num> ticks;
}

NumberAutoRst numberAuto({
  num min = 0,
  num max = 0,
  num interval,
  num minTickInterval,
  int minCount = _minCount,
  int maxCount = _maxCount,
  num minLimit = double.negativeInfinity,
  num maxLimit = double.infinity,
  List snapArray,
}) {
  final ticks = [];
  final isFixedCount = minCount == maxCount;
  var avgCount = (minCount + maxCount) ~/ 2;
  var count = avgCount;
  snapArray ??= (isFixedCount ? _snapCountArray : _snapArray);

  if (min == minLimit && max == maxLimit && isFixedCount) {
    interval = (max - min) / (count - 1);
  }

  if (max == min) {
    if (min == 0) {
      max = 1;
    } else {
      if (min > 0) {
        min = 0;
      } else {
        max = 0;
      }
    }
    if (max - min < 5 && interval == null && max - min >= 1) {
      interval = 1;
    }
  }

  if (interval == null) {
    final temp = (max - min) / (avgCount -1);
    interval = auto_util.snapFactorTo(temp, snapArray, auto_util.SnapType.ceil);
    if (maxCount != minCount) {
      count = (max - min) ~/ interval;
      count = count.clamp(minCount, maxCount);
      interval = auto_util.snapFactorTo((max - min) / (count - 1), snapArray, auto_util.SnapType.floor);
    }
  }

  if (minTickInterval != null && interval < minTickInterval) {
    interval = minTickInterval;
  }
  if (interval != null || maxCount != minCount) {
    max = math.min(auto_util.snapMultiple(max, interval, auto_util.SnapType.ceil), maxLimit);
    min = math.max(auto_util.snapMultiple(min, interval, auto_util.SnapType.floor), minLimit);

    count = ((max - min) / interval).round();
    min = auto_util.fixedBase(min, interval);
    max = auto_util.fixedBase(max, interval);
  } else {
    avgCount = avgCount.floor();
    final avg = (max + min) / 2;
    final avgTick = auto_util.snapMultiple(avg, interval, auto_util.SnapType.ceil);
    final sideCount = (avgCount - 2) ~/ 2;
    var maxTick = avgTick + sideCount * interval;
    var minTick;
    if (avgCount % 2 == 0) {
      minTick = avgTick - sideCount * interval;
    } else {
      minTick = avgTick - (sideCount + 1) * interval;
    }

    while (maxTick < max) {
      maxTick = auto_util.fixedBase(maxTick + interval, interval);
    }
    while (minTick > min) {
      minTick = auto_util.fixedBase(minTick - interval, interval);
    }

    max = maxTick;
    min = minTick;
  }

  max = math.min(max, maxLimit);
  min = math.max(min, minLimit);

  ticks.add(min);
  for (var i = 1; i < count; i++) {
    final tickValue = auto_util.fixedBase(interval * i + min, interval);
    if (tickValue < max) {
      ticks.add(tickValue);
    }
  }
  if (ticks.last < max) {
    ticks.add(max);
  }
  return NumberAutoRst(min, max, interval, count, ticks);
}
