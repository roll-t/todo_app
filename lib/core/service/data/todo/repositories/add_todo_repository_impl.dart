import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/service/domain/todo/repositories/add_todo_repository.dart';
import 'package:todo_app/core/service/sources/todo_service.dart'; // Đảm bảo bạn đã import TodoService

class AddTodoRepositoryImpl implements AddTodoRepository {
  final TodoService _todoService;

  AddTodoRepositoryImpl(this._todoService);

  @override
  Future<void> saveTodo(TodoItemModel todo) async {
    try {
      await _todoService.add(todo);
    } catch (e) {
      throw Exception('Error saving todo: $e');
    }
  }
}
