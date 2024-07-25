import 'package:deemmi/core/global_widgets/primary_style_button.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color color;
  final bool bold;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    required this.color,
    this.bold = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: PrimaryStyleButton(
        onPressed: onPressed,
        color: color,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: onPressed != null
                    ? Colors.white
                    : AppColor.secondaryContentGray,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
