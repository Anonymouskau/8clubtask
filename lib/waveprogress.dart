import 'dart:math';
import 'package:flutter/material.dart';

class WaveProgress extends StatefulWidget {
  final double progress; // 0.0 → 1.0
  final Color color;
  final double height;

  const WaveProgress({
    super.key,
    required this.progress,
    required this.color,
    this.height = 6,
  });

  @override
  State<WaveProgress> createState() => _WaveProgressState();
}

class _WaveProgressState extends State<WaveProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CustomPaint(
              painter: _WavePainter(
                animationValue: _controller.value,
                progress: widget.progress,
                color: widget.color,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;
  final double progress;
  final Color color;

  _WavePainter({
    required this.animationValue,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waveHeight = size.height * 0.6;
    final fillHeight = size.height * (1 - progress);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    for (double x = 0; x <= size.width; x++) {
      double y = sin((x / size.width * 2 * pi) + (animationValue * 2 * pi))
              * waveHeight +
          fillHeight;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}
