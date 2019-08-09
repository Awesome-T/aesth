import 'dart:ui' show Canvas, Paint, Rect, PaintingStyle, BlendMode, Path;

class Context {
  Context(this.canvas);

  final Canvas canvas;

  final List<Paint> _paintStack = [Paint()];
  
  Paint get _paint => _paintStack.last;

  Path _path;

  void fillRect(num x, num y, num width, num height) {
    _paint.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), _paint);
  }
  
  void strokeRect(num x, num y, num width, num height) {
    _paint.style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), _paint);
  }

  void clearRect(num x, num y, num width, num height) {
    final clearPaint = Paint();
    clearPaint.blendMode = BlendMode.clear;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), clearPaint);
  }

  
}

