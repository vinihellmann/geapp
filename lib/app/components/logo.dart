import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';

class RobotHeadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = TColor.text.primary;
    final eyePaint = Paint()..color = TColor.primary.dark.withAlpha(255);
    final antennaPaint = Paint()
      ..color = TColor.text.primary
      ..strokeWidth = 4;

    // Cabeça
    final headRect = Rect.fromLTWH(15, 20, 40, 40);
    final headRRect = RRect.fromRectAndRadius(headRect, Radius.circular(20));
    canvas.drawRRect(headRRect, paint);

    // Orelhas
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.55), 12, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.55), 12, paint);

    // Olhos
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.5), 6, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.5), 6, eyePaint);

    // Antena
    final antennaTop = Offset(size.width * 0.5, 10);
    final antennaBase = Offset(size.width * 0.5, 20);
    canvas.drawLine(antennaTop, antennaBase, antennaPaint);
    canvas.drawCircle(antennaTop, 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LogoGEApp extends StatelessWidget {
  const LogoGEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(70, 70),
          painter: RobotHeadPainter(),
        ),
      ],
    );
  }
}
