import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';

class SegmentedCircularProgress extends StatelessWidget {
  final double current; // <-- change from int to double
  final int totalSegments;
  final double radius;
  final double strokeWidth;
  final String? title;
  final String? reamaining;

  const SegmentedCircularProgress({
    Key? key,
    required this.current,
    this.totalSegments = 100,
    this.radius = 100,
    this.strokeWidth = 3,
    this.title = "",
    this.reamaining = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SegmentedProgressPainter(
        current: current,
        totalSegments: totalSegments,
        strokeWidth: strokeWidth,
      ),
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Center(
          child: title != "" ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text(
                title ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '$reamaining',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ) :  Text(
            '${current.toInt()}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _SegmentedProgressPainter extends CustomPainter {
  final double current;
  final int totalSegments;
  final double strokeWidth;

  _SegmentedProgressPainter({
    required this.current,
    required this.totalSegments,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - strokeWidth;

    final anglePerSegment = 2 * pi / totalSegments;

    final activePaint = Paint()
      ..color = AppColor.primaryColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final inactivePaint = Paint()
      ..color = AppColor.lightgray
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    int segmentsToDraw = current.ceil().clamp(0, totalSegments);

    for (int i = 0; i < totalSegments; i++) {
      final angle = i * anglePerSegment - pi / 2;
      final segmentLength = 16.0;

      final start = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final end = Offset(
        center.dx + (radius - segmentLength) * cos(angle),
        center.dy + (radius - segmentLength) * sin(angle),
      );

      final paint = i < segmentsToDraw ? activePaint : inactivePaint;

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}