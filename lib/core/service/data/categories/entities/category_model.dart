import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String color;
  final int? iconCodePoint;
  final String? iconFontFamily;
  final String? iconFontPackage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    this.iconCodePoint,
    this.iconFontFamily,
    this.iconFontPackage,
  });

  factory CategoryModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      name: data['name'] as String,
      color: data['color'] as String,
      iconCodePoint: data['icon_code_point'] as int?,
      iconFontFamily: data['icon_font_family'] as String?,
      iconFontPackage: data['icon_font_package'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'color': color,
      'icon_code_point': iconCodePoint,
      'icon_font_family': iconFontFamily,
      'icon_font_package': iconFontPackage,
    };
  }

  IconData get icon {
    return iconCodePoint != null
        ? IconData(
            iconCodePoint!,
            fontFamily: iconFontFamily,
            fontPackage: iconFontPackage,
          )
        : Icons.clear;
  }
}
