import 'package:todo_app/core/service/public/data/entities/category_model.dart';
import 'package:todo_app/core/service/public/data/source/category_service.dart';
import 'package:todo_app/core/service/public/domain/repositories/category_repository.dart';

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
