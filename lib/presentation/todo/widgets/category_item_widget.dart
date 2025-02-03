import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/hexColor.dart';
import 'package:todo_app/core/service/data/categories/entities/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(
      {super.key, required this.category, required this.isCategorySelected});

  final CategoryModel category;
  final bool isCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: category.color.toColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(1000),
        border: isCategorySelected
            ? Border.all(
                color: category.color.toColor(),
                width: 2,
              )
            : Border.all(
                color: const Color.fromARGB(
                  255,
                  209,
                  205,
                  205,
                ),
                width: 1,
              ),
      ),
      child: Center(
        child: Icon(
          category.icon,
          color: category.color.toColor(),
        ),
      ),
    );
  }
}
