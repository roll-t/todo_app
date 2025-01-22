

import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

abstract class AddTodoRepository {
  Future<void> saveTodo(TodoItemModel todo);
}