import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  Color color;
  IconData icons;
  CategoryModel({required this.id, required this.color, required this.icons});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color.value,
      'icons': icons.toString(),
    };
  }
}
