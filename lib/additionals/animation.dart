import 'dart:math';
import 'package:flutter/material.dart';

class SmileyAnimation extends StatefulWidget {
  @override
  _SmileyAnimationState createState() => _SmileyAnimationState();
}

class _SmileyAnimationState extends State<SmileyAnimation>
    with TickerProviderStateMixin {
  late AnimationController blinkController;
  late Animation<double> blinkAnimation;

  late AnimationController floatController;
  late Animation<double> floatAnimation;

  late AnimationController smileStretchController;
  late Animation<double> smileStretchAnimation;

  late AnimationController tiltController;
  late Animation<double> tiltAnimation;

  late AnimationController sparkleController;
  late Animation<double> sparkleOpacity;

  late AnimationController heartController;
  late Animation<double> heartOpacity;
  late Animation<Offset> heartOffset;

  late AnimationController squishController;
  late Animation<double> squishAnimation;

  late AnimationController blushController;
  late Animation<double> blushOpacity;

  bool isWinking = false;
  bool leftEye = true;
  bool isPetting = false;
  bool isSleeping = false;

  @override
  void initState() {
    super.initState();

    // Blinking animation
    blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    blinkAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: blinkController, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(seconds: 2), _blinkLoop);

    // Floating animation
    floatController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
    );

    // Smile stretch animation
    smileStretchController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat(reverse: true);

    smileStretchAnimation = Tween<double>(begin: 0.3, end: 0.5).animate(
      CurvedAnimation(parent: smileStretchController, curve: Curves.easeInOut),
    );

    // Tilt animation
    tiltController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    tiltAnimation = Tween<double>(begin: 0.0, end: 0.08).animate(
      CurvedAnimation(parent: tiltController, curve: Curves.elasticInOut),
    );

    // Sparkle animation
    sparkleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    sparkleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(sparkleController);

    // Heart animation
    heartController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    heartOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: heartController, curve: Curves.easeOut),
    );
    heartOffset = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -1),
    ).animate(CurvedAnimation(parent: heartController, curve: Curves.easeOut));

    heartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 300), () {
          heartController.reverse();
        });
      }
    });

    // Squish animation
    squishController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    squishAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: squishController, curve: Curves.easeOutBack),
    );

    // Blush animation
    blushController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    blushOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(blushController);

    _startSleepTimer();
  }

  void _startSleepTimer() {
    Future.delayed(Duration(seconds: 60), () {
      if (mounted && !isPetting) {
        setState(() => isSleeping = true);
      }
    });
  }

  void _blinkLoop() async {
    while (mounted) {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isWinking = Random().nextBool();
        leftEye = Random().nextBool();
      });
      await blinkController.forward();
      await blinkController.reverse();
    }
  }

  void _onPet() {
    setState(() => isSleeping = false);
    _startSleepTimer();

    if (!isPetting) {
      isPetting = true;
      tiltController.forward().then((_) => tiltController.reverse().then((_) {
            isPetting = false;
          }));
      squishController.forward(from: 0);

      // Show sparkle only if not blinking or winking
      if (blinkAnimation.value > 0.7 && !isWinking) {
        sparkleController.forward(from: 0);
        Future.delayed(Duration(milliseconds: 400), () {
          if (mounted) sparkleController.reverse();
        });
      }

      // Trigger blush
      blushController.forward(from: 0);
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) blushController.reverse();
      });

      // Trigger heart pop
     //heartController.forward(from: 1);
    }
  }

  @override
  void dispose() {
    blinkController.dispose();
    floatController.dispose();
    smileStretchController.dispose();
    tiltController.dispose();
    sparkleController.dispose();
    heartController.dispose();
    squishController.dispose();
    blushController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPet,
      onPanUpdate: (_) => _onPet(),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          floatAnimation,
          smileStretchAnimation,
          tiltAnimation,
          sparkleController,
          heartController,
          squishController,
          blushController,
        ]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, floatAnimation.value),
            child: Transform.rotate(
              angle: tiltAnimation.value,
              child: Transform.scale(
                scale: squishAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(220, 200),
                      painter: SmileyPainter(
                        blinkFactor: isSleeping ? 0.0 : blinkAnimation.value,
                        isWinking: isSleeping ? false : isWinking,
                        leftEye: leftEye,
                        smileStretch: smileStretchAnimation.value,
                      ),
                    ),
                    if (!isSleeping && !isWinking && blinkAnimation.value > 0.7) ...[
                      Positioned(
                        left: 30,
                        top: 30,
                        child: Opacity(
                          opacity: sparkleOpacity.value,
                          child: Icon(Icons.star, color: Colors.amber, size: 14),
                        ),
                      ),
                    ],
                    if (isSleeping)
                      Positioned(
                        top: 20,
                        child: Text('💤', style: TextStyle(fontSize: 28)),
                      ),
                    // Heart emoji float up
                    SlideTransition(
                      position: heartOffset,
                      child: Opacity(
                        opacity: heartOpacity.value,
                        child: Text(
                          '❤️',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    // Blush circles
                    Positioned(
                      left: 50,
                      top: 115,
                      child: Opacity(
                        opacity: blushOpacity.value,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade200,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 50,
                      top: 115,
                      child: Opacity(
                        opacity: blushOpacity.value,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade200,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  final double blinkFactor;
  final bool isWinking;
  final bool leftEye;
  final double smileStretch;

  SmileyPainter({
    required this.blinkFactor,
    required this.isWinking,
    required this.leftEye,
    required this.smileStretch,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint = Paint()..color = Colors.black;

    final eyeWidth = size.width * 0.25;
    final eyeHeight = size.height * 0.43 * blinkFactor;
    final eyeYOffset = size.height * 0.3;

    final leftEyeCenter = Offset(size.width * 0.25, eyeYOffset);
    final rightEyeCenter = Offset(size.width * 0.75, eyeYOffset);

    final leftClosed = isWinking && leftEye;
    final rightClosed = isWinking && !leftEye;

    canvas.drawOval(
      Rect.fromCenter(
        center: leftEyeCenter,
        width: eyeWidth,
        height: leftClosed ? 3 : eyeHeight,
      ),
      eyePaint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: rightEyeCenter,
        width: eyeWidth,
        height: rightClosed ? 3 : eyeHeight,
      ),
      eyePaint,
    );

    final smilePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width * 0.045
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final smileWidth = size.width * smileStretch;
    final smileHeight = size.height * 0.22;

    final smileRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.72),
      width: smileWidth,
      height: smileHeight,
    );

    canvas.drawArc(smileRect, pi / 8, pi * 6 / 8, false, smilePaint);
  }

  @override
  bool shouldRepaint(covariant SmileyPainter oldDelegate) {
    return blinkFactor != oldDelegate.blinkFactor ||
        smileStretch != oldDelegate.smileStretch ||
        isWinking != oldDelegate.isWinking ||
        leftEye != oldDelegate.leftEye;
  }
}
