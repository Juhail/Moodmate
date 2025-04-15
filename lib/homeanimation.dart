import 'package:flutter/material.dart';




class AnimatedWavyHeader extends StatefulWidget {
  final Widget child;
  const AnimatedWavyHeader({super.key, required this.child});
  @override
  _AnimatedWavyHeaderState createState() => _AnimatedWavyHeaderState();
}

class _AnimatedWavyHeaderState extends State<AnimatedWavyHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 25).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return CustomPaint(
          painter: WavyPainter(offset: _animation.value),
          child: ClipPath(
            clipper: GreenContainerClipper(),
            child: Container(
              width: double.infinity,
              height: 350,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class WavyPainter extends CustomPainter {
  final double offset;
  WavyPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFB6CD7D)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.lineTo(0, size.height * 0.85);

    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.15 + offset,
      size.width,
      size.height * 0.85,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavyPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

class GreenContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.15,
      size.width,
      size.height * 0.85,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
