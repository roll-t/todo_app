

import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';

abstract class AddTodoRepository {
  Future<void> saveTodo(TodoItemModel todo);
}