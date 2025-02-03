

import 'package:todo_app/core/service/data/categories/entities/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> fetchCategories();
}