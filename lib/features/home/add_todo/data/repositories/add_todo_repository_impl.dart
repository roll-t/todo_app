import 'package:todo_app/core/service/api/data/source/todo/todo_service.dart'; // Đảm bảo bạn đã import TodoService
import 'package:todo_app/features/home/add_todo/domain/repositories/add_todo_repository.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

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
