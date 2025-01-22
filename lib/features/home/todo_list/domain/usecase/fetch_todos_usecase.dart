import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/todo_list/domain/repositories/todo_repository.dart';

class FetchTodosUsecase {
  final TodoRepository _repository;
  FetchTodosUsecase(this._repository);
  
  Future<List<TodoItemModel>> call() async {
    return _repository.fetchTodos();
  }
}
