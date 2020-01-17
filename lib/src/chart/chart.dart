import 'package:flutter/widgets.dart'
  show
    EdgeInsets,
    State,
    StatefulWidget;

import 'package:aesth/src/scale/scale.dart' show Scale;
import 'package:aesth/src/coord/coord.dart' show Coord;
import 'package:aesth/src/component/axis/axis.dart' show Axis;
import 'package:aesth/src/geom/geom.dart' show Geom;
import 'package:aesth/src/component/legend/legend.dart' show Legend;
import 'package:aesth/src/component/tooltip/tooltip.dart' show Tooltip;
import 'package:aesth/src/component/guide/guide.dart' show Guide;

class Chart<D> extends StatefulWidget {
  Chart({
    this.width,
    this.widthPercent,
    this.height,
    this.heightPercent,
    this.padding,
    this.paddingPercent,
    this.data,
    this.scales,
    this.coord,
    this.axes,
    this.geoms,
    this.legend,
    this.tooltip,
    this.guides,
  });

  final num width;
  final num widthPercent;

  final num height;
  final num heightPercent;

  final EdgeInsets padding;
  final EdgeInsets paddingPercent;

  final List<D> data;

  final List<Scale> scales;

  final Coord coord;

  final List<Axis> axes;

  final List<Geom> geoms;

  final Legend legend;

  final Tooltip tooltip;

  final List<Guide> guides;

  @override
  State createState() => null;

  Scale createScale(String field) => null;
}
