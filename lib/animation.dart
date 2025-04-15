import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class SmileyAnimation extends StatefulWidget {
  @override
  _SmileyAnimationState createState() => _SmileyAnimationState();
}

class _SmileyAnimationState extends State<SmileyAnimation> with TickerProviderStateMixin {
  late AnimationController blinkController;
  late Animation<double> blinkAnimation;

  late AnimationController floatController;
  late Animation<double> floatAnimation;

  @override
  void initState() {
    super.initState();

    // Blink animation
    blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    blinkAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: blinkController, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(seconds: 2), _blinkLoop);

    // Floating up-down animation
    floatController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
    );
  }

  void _blinkLoop() async {
    while (mounted) {
      await Future.delayed(Duration(seconds: 3 + (DateTime.now().millisecond % 3)));
      await blinkController.forward();
      await blinkController.reverse();
    }
  }

  @override
  void dispose() {
    blinkController.dispose();
    floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, floatAnimation.value),
          child: AnimatedBuilder(
            animation: blinkAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(220, 200),
                painter: SmileyPainter(blinkFactor: blinkAnimation.value),
              );
            },
          ),
        );
      },
    );
  }
}


class SmileyPainter extends CustomPainter {
  final double blinkFactor;

  SmileyPainter({required this.blinkFactor});

  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint = Paint()..color = Colors.black;

    // Slightly bigger and wider eyes
    final eyeWidth = size.width * 0.25;
    final eyeHeight = size.height * 0.43 * blinkFactor;
    final eyeYOffset = size.height * 0.3;

    final leftEyeCenter = Offset(size.width * 0.25, eyeYOffset);
    final rightEyeCenter = Offset(size.width * 0.75, eyeYOffset);

    canvas.drawOval(
      Rect.fromCenter(center: leftEyeCenter, width: eyeWidth, height: eyeHeight),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: rightEyeCenter, width: eyeWidth, height: eyeHeight),
      eyePaint,
    );

    // Refined smile: deeper arc, less thick, more pleasant
    final smilePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width * 0.045
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final smileWidth = size.width * 0.3;
    final smileHeight = size.height * 0.22;

    final smileRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.72),
      width: smileWidth,
      height: smileHeight,
    );

    // Deeper arc (pi / 8 to 7pi / 8)
    canvas.drawArc(smileRect, pi / 8, pi * 6 / 8, false, smilePaint);
  }

  @override
  bool shouldRepaint(covariant SmileyPainter oldDelegate) {
    return blinkFactor != oldDelegate.blinkFactor;
  }
}
