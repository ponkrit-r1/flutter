import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PrimaryStyleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color color;

  const PrimaryStyleButton({
    super.key,
    required this.child,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              // onPrimary: Colors.white,
              // primary: primaryColor,
              // onSurface: kDisabled,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              textStyle: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              return 0;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) return Colors.white;
              return Colors.white;
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColor.disableColor;
              }
              return color;
            },
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
