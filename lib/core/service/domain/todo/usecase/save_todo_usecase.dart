import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/service/domain/todo/repositories/add_todo_repository.dart';

class SaveTodoUsecase {
  final AddTodoRepository _repository;

  SaveTodoUsecase(this._repository);

  Future<void> call(TodoItemModel todo) async {
    await _repository.saveTodo(todo);
  }
}
