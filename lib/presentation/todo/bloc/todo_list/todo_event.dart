abstract class TodoEvent {}

class ToggleTodoEvent extends TodoEvent {
  final int index;
  final bool isCheck;
  ToggleTodoEvent({required this.index, this.isCheck = false});
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  DeleteTodoEvent({required this.id});
}

class InitializeTodoEvent extends TodoEvent {}
