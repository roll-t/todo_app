import 'package:todo_app/core/service/data/categories/entities/category_model.dart';
import 'package:todo_app/core/service/domain/cateogies/repositories/category_repository.dart';

class FetchCategoryUsecase {
  final CategoryRepository _repository;
  FetchCategoryUsecase(this._repository);

  Future<List<CategoryModel>> call() async {
    return await _repository.fetchCategories();
  }
}
