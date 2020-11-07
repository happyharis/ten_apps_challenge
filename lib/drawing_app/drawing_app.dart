import 'dart:ui';

import 'package:flutter/material.dart';

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  List<DrawingPoint> points = [];
  AppBar appBar = AppBar(
    title: Text('Drawing App'),
  );
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    onDraw(details) {
      RenderBox renderBox = context.findRenderObject();
      Offset location = renderBox.globalToLocal(details.globalPosition);
      Offset _points = Offset(
        location.dx,
        location.dy - topPadding - appBar.preferredSize.height,
      );
      setState(() {
        points.add(
          DrawingPoint(
            points: _points,
            paint: Paint()
              ..strokeCap = StrokeCap.round
              ..strokeWidth = 3,
          ),
        );
      });
    }

    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onPanUpdate: onDraw,
        onPanStart: onDraw,
        onPanEnd: (details) => setState(() => points.add(null)),
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(points),
        ),
      ),
    );
  }
}

class DrawingPoint {
  Paint paint;
  Offset points;

  DrawingPoint({this.paint, this.points});
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> _points;

  DrawingPainter(this._points);
  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < _points.length - 1; index++) {
      final currentPoint = _points[index];
      final pointAhead = _points[index + 1];
      final paint = _points[index]?.paint ?? Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3;
      // When dragging continuously, draw lines
      if (currentPoint != null && pointAhead != null) {
        canvas.drawLine(currentPoint.points, pointAhead.points, paint);
      } else if (currentPoint != null && pointAhead == null) {
        // When stopping, draw dots
        final currentPointAhead = Offset(
          currentPoint.points.dx + 0.1,
          currentPoint.points.dy + 0.1,
        );
        canvas.drawPoints(
          PointMode.points,
          [currentPoint.points, currentPointAhead],
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
