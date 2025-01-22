import 'package:todo_app/core/service/public/data/entities/category_model.dart';
import 'package:todo_app/core/service/public/domain/repositories/category_repository.dart';

class FetchCategoryUsecase {
  final CategoryRepository _repository;
  FetchCategoryUsecase(this._repository);

  Future<List<CategoryModel>> call() async {
    return await _repository.fetchCategories();
  }
}
