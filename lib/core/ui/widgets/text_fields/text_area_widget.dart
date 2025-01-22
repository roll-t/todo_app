import 'package:flutter/material.dart';

class TextAreaWidget extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final int minLines;
  final TextEditingController? controller;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;

  const TextAreaWidget({
    super.key,
    this.hintText = "Enter text here...",
    this.maxLines = 5,
    this.minLines = 3,
    this.controller,
    this.borderRadius = 8.0,
    this.borderColor = Colors.grey,
    this.padding = const EdgeInsets.all(12.0),
    this.textStyle,
    this.hintStyle,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      style: textStyle ?? const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            hintStyle ?? const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: padding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: .5),
        ),
      ),
    );
  }
}
