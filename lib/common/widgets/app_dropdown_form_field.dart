import 'package:deemmi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDropDownFormField<T> extends StatelessWidget {
  final Function(T?) onItemSelected;
  final List<T> items;
  final T? selectedValue;
  final String hintValue;

  const AppDropDownFormField({
    super.key,
    required this.onItemSelected,
    required this.items,
    this.selectedValue,
    required this.hintValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(color: AppColor.borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(color: AppColor.borderColor, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString(), style: TextStyle(fontSize: 14)),
        );
      }).toList(),
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.grey,
      ),
      hint: Text(
        hintValue,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      onChanged: onItemSelected,
    );
  }
}
