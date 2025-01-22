import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

abstract class TodoRepository {
  Future<List<TodoItemModel>> fetchTodos();
  Future<void> checkCompleteTodo(String todoId);
}
