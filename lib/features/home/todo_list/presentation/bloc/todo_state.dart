import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

class TodoState {
  final bool loading;
  final List<TodoItemModel> items;
  final String? errorMessage;
  final bool isWaiting;

  TodoState({
    required this.items,
    required this.loading,
    required this.isWaiting,
    this.errorMessage,
  });

  TodoState copyWith({
    List<TodoItemModel>? items,
    bool? loading,
    String? errorMessage,
    bool? isWaiting,
  }) {
    return TodoState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      isWaiting: isWaiting ?? this.isWaiting,
      errorMessage: errorMessage,
    );
  }
}

class TodoLoadingState extends TodoState {
  TodoLoadingState() : super(items: [], loading: true, isWaiting: false);
}

class TodoErrorState extends TodoState {
  TodoErrorState(String errorMessage)
      : super(items: [], loading: false, errorMessage: errorMessage, isWaiting: false);
}

class TodoLoadedState extends TodoState {
  TodoLoadedState(List<TodoItemModel> items)
      : super(items: items, loading: false, isWaiting: false);
}

class TodoEmptyState extends TodoState {
  TodoEmptyState() : super(items: [], loading: false, isWaiting: false);
}
