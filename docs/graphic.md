## 容器

Canvas(ui.Canvas container, GestureNotifier gestureNotifier)

## 图形配置

ShapeCfg

CircleCfg(Offset center, double radius, Paint paint)

EllipseCfg(Rect rect, Paint paint)

ImageCfg(Image image, Offset point, Paint paint)

LineCfg(Offset point1, Offset point2, Paint paint)

MarkerCfg(Symbols symbol, double radius, Paint paint)

Symbols {circle, square, diamond, triangle, triangleDown}

PathCfg(Path path, Paint paint, [Arrow startArrow, Arrow endArrow])

Arrow(Path path, double distance)

PolygonCfg(List<Offset> points, Paint paint)

PolylineCfg(List<Offset> points, Paint paint, [Arrow startArrow, Arrow endArrow])

RectCfg(Rect rect, Paint paint, [Radius radius])

TextCfg(TextSpan textSpan)

## 事件

Gestures{}