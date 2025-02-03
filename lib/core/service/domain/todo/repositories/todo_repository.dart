import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';

abstract class TodoRepository {
  Future<List<TodoItemModel>> fetchTodos();
  Future<void> checkCompleteTodo(String todoId);
  Future<void> checkUnCompleteTodo(String todoId);
  Future<bool> deleteTodo(String todoId);
}
