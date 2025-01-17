import 'package:todo_app/features/home/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/domain/repositories/todo_repository.dart';

class FetchTodosUsecase {
  final TodoRepository _repository;
  FetchTodosUsecase(this._repository);
  
  Future<List<TodoItemModel>> call() async {
    return _repository.fetchTodos();
  }
}
