import 'package:todo_app/features/home/data/entities/todo_item_model.dart';

class TodoState {
  final List<TodoItemModel> items;

  TodoState(this.items);

  TodoState copyWith({List<TodoItemModel>? items}) {
    return TodoState(items ?? this.items);
  }
}

class TodoLoadingState extends TodoState {
  TodoLoadingState() : super([]);
}
