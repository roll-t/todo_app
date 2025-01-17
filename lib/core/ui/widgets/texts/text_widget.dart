import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final FontWeight? fontWeight;
  final int maxLine;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double letterSpacing;
  final bool strikethrough;
  final double height;

  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.size = 16.0,
      this.maxLine = 999,
      this.fontWeight,
      this.textAlign = TextAlign.start,
      this.overflow = TextOverflow.ellipsis,
      this.letterSpacing = 0.0,
      this.strikethrough = false,
      this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        decoration: strikethrough ? TextDecoration.lineThrough : null,
      ),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
