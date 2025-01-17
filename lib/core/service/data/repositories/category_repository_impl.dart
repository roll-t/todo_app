import 'package:flutter/material.dart';
import 'package:todo_app/core/service/data/entities/category_model.dart';
import 'package:todo_app/core/service/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return <CategoryModel>[
        CategoryModel(id: "1", color: Colors.red, icons: Icons.message_rounded),
        CategoryModel(
            id: "2",
            color: const Color.fromARGB(255, 43, 136, 46),
            icons: Icons.calendar_month_rounded),
        CategoryModel(
            id: "3",
            color: const Color.fromARGB(255, 155, 143, 35),
            icons: Icons.gif_box_rounded)
      ];
    } catch (e) {
      print(e);
      return <CategoryModel>[];
    }
  }
}
