import 'package:todo_app/features/home/add_todo/domain/repositories/add_todo_repository.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

class SaveTodoUsecase {
  final AddTodoRepository _repository;

  SaveTodoUsecase(this._repository);

  Future<void> call(TodoItemModel todo) async {
    await _repository.saveTodo(todo);
  }
}
