import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/todo_list/domain/usecase/check_complete_todo_usecase.dart';
import 'package:todo_app/features/home/todo_list/domain/usecase/fetch_todos_usecase.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FetchTodosUsecase fetchTodosUsecase;
  final CheckCompleteTodoUsecase checkCompleteTodoUsecase;

  TodoBloc(this.fetchTodosUsecase, this.checkCompleteTodoUsecase)
      : super(TodoState(items: [], loading: false, isWaiting: false)) {
    on<InitializeTodoEvent>(_onInitializeTodoEvent);
    on<ToggleTodoEvent>(_onToggleTodoEvent);
  }

  Future<void> _onInitializeTodoEvent(
      InitializeTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      final todos = await fetchTodosUsecase();
      emit(state.copyWith(items: todos, loading: false));
    } catch (e) {
      emit(state.copyWith(
        items: [],
        loading: false,
        errorMessage: 'Failed to load todos: ${e.toString()}',
      ));
    }
  }

  Future<void> _onToggleTodoEvent(
      ToggleTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(state.copyWith(isWaiting: true));
      final updatedItems = List<TodoItemModel>.from(state.items);
      updatedItems[event.index] =
          updatedItems[event.index].copyWith(isDone: event.isCheck);
      await checkCompleteTodoUsecase(updatedItems[event.index].id);
      emit(state.copyWith(items: updatedItems, isWaiting: false));
    } catch (error) {
      emit(state.copyWith(
        isWaiting: false,
        errorMessage: 'Failed to update todo: ${error.toString()}',
      ));
    }
  }
}
