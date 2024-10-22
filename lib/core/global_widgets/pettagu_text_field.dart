import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

enum ClearButtonMode {
  never,
  always,
  whileEditing,
}

class PettaguTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isSearch;
  final bool isPicker; // show down arrow
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final String? errorText;

  String? get displayError => errorText != null ? '$errorText' : null;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final ClearButtonMode clearButtonMode;
  final bool readOnly;

  final String? actionTitle;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  final bool? enabled;

  /// Field name, showing at the top of the textfield.
  final String? labelText;

  /// Helper text showing at the bottom of the textfield.
  final String? helperText;

  final List<TextInputFormatter>? inputFormatters;

  final Color fillColor;

  final int? maxLength;

  const PettaguTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.labelText,
    this.helperText,
    this.obscureText = false,
    this.textInputAction,
    this.onEditingComplete,
    this.errorText,
    this.validator,
    this.initialValue,
    this.actionTitle,
    this.onPressed,
    this.enabled,
    this.inputFormatters,
    this.keyboardType,
    this.clearButtonMode = ClearButtonMode.never,
    this.focusNode,
    this.readOnly = false,
    this.isSearch = false,
    this.isPicker = false,
    this.fillColor = Colors.transparent,
    this.maxLength,
  }) : super(key: key);

  @override
  _PettaguTextField createState() => _PettaguTextField();
}

class _PettaguTextField extends State<PettaguTextField> {
  var _isPasswordVisible = false;
  var _isHelperTextVisible = false;
  var _hasFocus = false;

  bool get _enabled {
    if (widget.enabled == null) {
      return true;
    }

    if (widget.enabled!) {
      return true;
    } else {
      return false;
    }
  }

  Color get _fillColor {
    return AppColor.disableColor; // only disabled color right now
  }

  bool get _filled {
    if (_enabled) {
      return false;
    } else {
      return true;
    }
  }

  bool get _isObscureText {
    if (widget.obscureText) {
      return !_isPasswordVisible;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelWidget(),
          _textField(),
          if (_helperWidget() != null) _helperWidget()!
        ],
      ),
    );
  }

  Widget _textField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _hasFocus = hasFocus;
                _isHelperTextVisible = hasFocus;
              });
            },
            child: TextFormField(
              maxLines: widget.obscureText ? 1 : null,
              cursorColor: Theme.of(context).primaryColor,
              readOnly: widget.readOnly,
              focusNode: widget.focusNode,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              initialValue: widget.initialValue,
              validator: widget.validator,
              textInputAction: widget.textInputAction,
              obscureText: _isObscureText,
              controller: widget.controller,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlignVertical: TextAlignVertical.top,
              onEditingComplete: widget.onEditingComplete,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                errorMaxLines: 5,
                fillColor: widget.fillColor,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                errorText: widget.displayError,
                alignLabelWithHint: true,
                prefixIcon: _prefixIcon(context),
                suffixIcon: _suffixIcon(),
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
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textColor,
                    ),
              ),
            ),
          ),
        ),
        if (_actionWidget() != null) _actionWidget()!
      ],
    );
  }

  Widget? _actionWidget() {
    if (widget.actionTitle != null) {
      return Row(
        children: [
          const SizedBox(width: 11),
          SizedBox(
            height: 48,
            child: TextButton(
              onPressed: widget.onPressed,
              child: Text(widget.actionTitle!),
            ),
          ),
        ],
      );
    } else {
      return null;
    }
  }

  Widget? _helperWidget() {
    if (_isHelperTextVisible == false) {
      return null;
    }

    final helperText = widget.helperText;

    if (helperText != null) {
      return Text(
        helperText,
        style: Theme.of(context).textTheme.bodySmall,
      );
    } else {
      return null;
    }
  }

  Widget _labelWidget() {
    if (widget.labelText != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          widget.labelText!,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget? _prefixIcon(BuildContext context) {
    if (widget.isSearch) {
      return Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return null;
    }
  }

  Widget? _suffixIcon() {
    if (widget.errorText != null) {
      return const Icon(
        Icons.error,
        color: AppColor.redError,
      );
    }
    if (widget.obscureText) {
      return IconButton(
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
        icon: Icon(
          _isPasswordVisible
              ? Icons.remove_red_eye
              : Icons.visibility_off_rounded,
          color: AppColor.secondaryContentGray,
        ),
      );
    } else if (widget.clearButtonMode == ClearButtonMode.always) {
      return _clearButton();
    } else if (widget.clearButtonMode == ClearButtonMode.whileEditing &&
        _hasFocus) {
      return _clearButton();
    } else if (widget.isPicker) {
      return const Icon(Icons.chevron_right_rounded);
    } else {
      return null;
    }
    return null;
  }

  Widget _clearButton() {
    return IconButton(
      icon: const Icon(Icons.close_rounded),
      color: Colors.black,
      onPressed: () {
        widget.controller?.clear();
        setState(() {});
      },
    );
  }
}
