import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/service/domain/todo/repositories/todo_repository.dart';
import 'package:todo_app/core/service/sources/todo_service.dart';

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

  @override
  Future<void> checkUnCompleteTodo(String todoId) async {
    try {
      await _todoService.uncompleted(todoId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteTodo(String todoId) async {
    try {
      return await _todoService.delete(todoId);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
