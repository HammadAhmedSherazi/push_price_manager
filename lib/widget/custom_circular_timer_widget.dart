import '../export_all.dart';

class CustomCircularCountdownTimer extends StatefulWidget {
  final int durationInSeconds;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle? textStyle;
  final VoidCallback? onComplete;

  const CustomCircularCountdownTimer({
    super.key,
    required this.durationInSeconds,
    this.size = 180.0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.progressColor = Colors.teal,
    this.textStyle,
    this.onComplete,
  });

  @override
  State<CustomCircularCountdownTimer> createState() =>
      _CustomCircularCountdownTimerState();
}

class _CustomCircularCountdownTimerState
    extends State<CustomCircularCountdownTimer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String get _timeLeft {
    int seconds = (_controller.duration!.inSeconds * _controller.value).ceil();
    return "$seconds Sec";
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed && widget.onComplete != null) {
          widget.onComplete!(); // ✅ Call user-defined function
        }
      });

    _controller.reverse(from: 1.0); // Start the countdown
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _CountdownPainter(
                  progress: _controller.value,
                  backgroundColor: widget.backgroundColor,
                  progressColor: widget.progressColor,
                ),
              ),
              CircleAvatar(
                radius: widget.size / 2.6,
                backgroundColor: widget.progressColor,
                child: Text(
                  _timeLeft,
                  style: widget.textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CountdownPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  _CountdownPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final Paint fgPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;

    // Background circle
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc (reverse clockwise)
    final double startAngle = -pi / 2;
    final double sweepAngle = -2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CountdownPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
