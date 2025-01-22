import 'package:todo_app/core/service/api/data/source/todo/todo_service.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/todo_list/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService);

  @override
  Future<List<TodoItemModel>> fetchTodos() async {
    try {
      final todos = await _todoService.getAll();
      return todos;
    } catch (e) {
      print("Error fetching todos: $e");
      rethrow;
    }
  }

  @override
  Future<void> checkCompleteTodo(String todoId) async {
    try {
      await _todoService.completed(todoId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
