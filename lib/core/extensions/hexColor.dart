// ignore: file_names
import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColor() {
    String hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse('0x$hexColor'));
  }
}
