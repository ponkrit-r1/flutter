import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class AppInputFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String? labelText;
  final String? helperText;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  final int? maxLength;
  final String? value;

  const AppInputFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    this.labelText,
    this.helperText,
    this.inputFormatters,
    this.fillColor = Colors.white,
    this.maxLength,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                labelText!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              helperText: helperText,
              errorText: errorText,
              fillColor: fillColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              errorMaxLines: 5,
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.redError),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.secondaryContentGray,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.redError,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.secondaryContentGray,
                  ),
            ),
            obscureText: obscureText,
            keyboardType: keyboardType ?? TextInputType.text,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            onChanged: onChanged,
          ),
          if (helperText != null)
            Text(
              helperText!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
