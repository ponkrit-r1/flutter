import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final Color activeColor;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  const SecondaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.activeColor = AppColor.secondaryContentGray,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: activeColor, elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: BorderSide(color: activeColor)),
              textStyle: Theme.of(context).textTheme.labelLarge),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
              return 0;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) return Colors.grey;
              return backgroundColor;
            },
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
