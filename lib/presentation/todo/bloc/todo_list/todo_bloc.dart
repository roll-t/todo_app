import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/service/domain/todo/usecase/check_complete_todo_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/check_unCompleted_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/delete_todo_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/fetch_todos_usecase.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FetchTodosUsecase fetchTodosUsecase;
  final CheckCompleteTodoUsecase checkCompleteTodoUsecase;
  final CheckUncompletedUsecase checkUncompletedUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

  TodoBloc(this.fetchTodosUsecase, this.checkCompleteTodoUsecase,
      this.checkUncompletedUsecase, this.deleteTodoUsecase)
      : super(TodoState(items: [], loading: false, isWaiting: false)) {
    on<InitializeTodoEvent>(_onInitializeTodoEvent);
    on<ToggleTodoEvent>(_onToggleTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
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
      final updatedItem =
          state.items[event.index].copyWith(isDone: event.isCheck);
      if (event.isCheck) {
        await checkCompleteTodoUsecase(updatedItem.id);
      } else {
        await checkUncompletedUsecase(updatedItem.id);
      }
      final updatedItems = List<TodoItemModel>.from(state.items)
        ..[event.index] = updatedItem;
      emit(state.copyWith(items: updatedItems, isWaiting: false));
    } catch (error) {
      emit(state.copyWith(
        isWaiting: false,
        errorMessage: 'Error updating todo item: ${error.runtimeType}',
      ));
    }
  }

  Future<void> _onDeleteTodoEvent(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(state.copyWith(isWaiting: true));
      await deleteTodoUsecase(event.id);
      final updatedItems = state.items.where((todo) => todo.id != event.id).toList();
      emit(state.copyWith(items: updatedItems, isWaiting: false));
    } catch (error) {
      emit(state.copyWith(
        isWaiting: false,
        errorMessage: 'Error deleting todo item: ${error.toString()}',
      ));
    }
  }
}
