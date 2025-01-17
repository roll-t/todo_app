import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/home/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/domain/usecase/fetch_todos_usecase.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FetchTodosUsecase fetchTodosUsecase;

  TodoBloc(this.fetchTodosUsecase) : super(TodoState([])) {
    on<InitializeTodoEvent>(_onInitializeTodoEvent);
    on<ToggleTodoEvent>(_onToggleTodoEvent);
  }

  Future<void> _onInitializeTodoEvent(
      InitializeTodoEvent event, Emitter<TodoState> emit) async {
    try {
      final todos = await fetchTodosUsecase();
      emit(state.copyWith(items: todos));
    } catch (e) {
      emit(state.copyWith(items: []));
    }
  }

  void _onToggleTodoEvent(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final updatedItems = List<TodoItemModel>.from(state.items);
    updatedItems[event.index] =
        updatedItems[event.index].copyWith(isDone: event.isCheck);
    emit(state.copyWith(items: updatedItems));
  }
}
