

abstract class TodoEvent {}

class ToggleTodoEvent extends TodoEvent {
  final int index;
  final bool isCheck;
  ToggleTodoEvent({required this.index, this.isCheck = false});
}
class InitializeTodoEvent extends TodoEvent {}
