import 'coord.dart';

class PolarCoord extends Coord {
  PolarCoord({
    this.radius,
    this.innerRadius,
    this.startAngle,
    this.endAngle,
  });

  final num radius;

  final num innerRadius;

  final num startAngle;

  final num endAngle;
}
