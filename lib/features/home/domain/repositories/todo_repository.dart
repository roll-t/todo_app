import 'package:todo_app/features/home/data/entities/todo_item_model.dart';

abstract class TodoRepository {
  Future<List<TodoItemModel>> fetchTodos();
}
