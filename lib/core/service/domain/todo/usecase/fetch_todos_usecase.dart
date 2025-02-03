import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/service/domain/todo/repositories/todo_repository.dart';

class FetchTodosUsecase {
  final TodoRepository _repository;
  FetchTodosUsecase(this._repository);
  
  Future<List<TodoItemModel>> call() async {
    return _repository.fetchTodos();
  }
}
