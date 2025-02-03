import 'package:todo_app/core/service/data/categories/entities/category_model.dart';
import 'package:todo_app/core/service/domain/cateogies/repositories/category_repository.dart';
import 'package:todo_app/core/service/sources/category_service.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService categoryService;

  CategoryRepositoryImpl(this.categoryService);

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final categories = await categoryService.getAll();
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return <CategoryModel>[];
    }
  }
}
