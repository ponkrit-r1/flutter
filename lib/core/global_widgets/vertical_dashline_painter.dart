import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class VerticalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startY = 0;
    final paint = Paint()
      ..color = AppColor.secondaryContentGray
      ..strokeWidth = 1;
    while (startY < size.width) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
