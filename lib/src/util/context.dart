import 'dart:ui' show
  Canvas,
  Paint,
  Rect,
  PaintingStyle,
  BlendMode,
  Path,
  Offset,
  Radius,
  Color,
  StrokeCap,
  StrokeJoin,
  Shader;

class _DulPaint {
  final Paint strokePaint = Paint()..style = PaintingStyle.stroke;
  final Paint fillPaint = Paint()..style = PaintingStyle.fill;

  set fillStyle(Object value) {
    if (value is Color) {
      fillPaint.color = value;
      return;
    }
    if (value is Shader) {
      fillPaint.shader = value;
    }
  }

  set strokeStyle(Object value) {
    if (value is Color) {
      strokePaint.color = value;
      return;
    }
    if (value is Shader) {
      strokePaint.shader = value;
    }
  }

  set lineWidth(num value) {
    strokePaint.strokeWidth = value;
    fillPaint.strokeWidth = value;
  }

  set lineCap(StrokeCap type) {
    strokePaint.strokeCap = type;
    fillPaint.strokeCap = type;
  }

  set lineJoin(StrokeJoin type) {
    strokePaint.strokeJoin = type;
    fillPaint.strokeJoin = type;
  }

  set miterLimit(num value) {
    strokePaint.strokeMiterLimit = value;
    fillPaint.strokeMiterLimit = value;
  }
}

class Context {
  Context(this.canvas);

  final Canvas canvas;

  final List<_DulPaint> _paintStack = [_DulPaint()];
  
  _DulPaint get _paint => _paintStack.last;

  Path _path;

  void fillRect(num x, num y, num width, num height) {
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), _paint.fillPaint);
  }
  
  void strokeRect(num x, num y, num width, num height) {
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), _paint.strokePaint);
  }

  void clearRect(num x, num y, num width, num height) {
    final clearPaint = Paint();
    clearPaint.blendMode = BlendMode.clear;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), clearPaint);
  }

  void beginPath() {
    _path = Path();
  }

  void stroke([Path path]) {
    canvas.drawPath(path ?? _path, _paint.strokePaint);
  }

  void fill([Path path]) {
    canvas.drawPath(path ?? _path, _paint.fillPaint);
  }

  void closePath() {
    _path.close();
  }

  void moveTo(num x, num y) {
    _path.moveTo(x, y);
  }

  void lineTo(num x, num y) {
    _path.lineTo(x, y);
  }

  void arc(num x, num y, num radius, num startAngle, num endAngle, [bool anticlockwise = false]) {
    final sweepAngle = anticlockwise ? (startAngle - endAngle) : (endAngle - startAngle);
    _path.addArc(Rect.fromCircle(center: Offset(x, y), radius: radius), startAngle, sweepAngle);
  }

  void arcTo(num x1, num y1, num x2, num y2, num radius) {
    final subPath = Path();
    subPath.moveTo(x1, y1);
    subPath.arcToPoint(Offset(x2, y2), radius: Radius.circular(radius));
    subPath.addPolygon([Offset(x1, y1), Offset(x2, y2)], false);
    _path.addPath(subPath, Offset(0, 0));
  }

  void quadraticCurveTo(num cp1x, num cp1y, x, y) {
    _path.conicTo(cp1x, cp1y, x, y, 1);
  }

  void bezierCurveTo(num cp1x, num cp1y, num cp2x, num cp2y, x, y) {
    _path.cubicTo(cp1x, cp1y, cp2x, cp2y, x, y);
  }

  void rect(num x, num y, num width, num height) {
    _path.addRect(Rect.fromLTWH(x, y, width, height));
    _path.moveTo(0, 0);
  }

  set fillStyle(Color color) {
    _paint.fillStyle = color;
  }

  set strokeStyle(Color color) {
    _paint.strokeStyle = color;
  }
}

