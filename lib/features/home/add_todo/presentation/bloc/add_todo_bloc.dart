import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/service/public/domain/usecase/categories/fetch_category_usecase.dart';
import 'package:todo_app/features/home/add_todo/domain/usecase/save_todo_usecase.dart';
import 'package:todo_app/features/home/add_todo/presentation/bloc/add_todo_event.dart';
import 'package:todo_app/features/home/add_todo/presentation/bloc/add_todo_state.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final FetchCategoryUsecase fetchCategoryUsecase;
  final SaveTodoUsecase saveTodoUsecase;

  AddTodoBloc(this.fetchCategoryUsecase,this.saveTodoUsecase) : super(AddTodoState(categories: [])) {
    on<InitializeAddTodoEvent>(_onInitializeAddTodoEvent);
    on<SelectCategoryEvent>(_onSelectCategoryEvent);
    on<HandleSaveTodoEvent>(_onSaveTodoEvent);
    on<UpdateDateTimeEvent>(_onUpdateDateTimeEvent);
    on<UpdateDateEvent>(_onUpdateDateEvent);
    on<UpdateTimeEvent>(_onUpdateTimeEvent);
    on<UpdateTitleTaskEvent>(_onUpdateTitleTaskEvent);
    on<UpdateNotesEvent>(_onUpdateNotesEvent);
  }

  Future<void> _onInitializeAddTodoEvent(
      InitializeAddTodoEvent event, Emitter<AddTodoState> emit) async {
    try {
      final categories = await fetchCategoryUsecase();
      final currentDate = DateTime.now();
      final currentTime = TimeOfDay.fromDateTime(currentDate);

      emit(state
          .updateCategories(categories)
          .updateDateAndTime(currentDate, currentTime));
    } catch (e) {
      final currentDate = DateTime.now();
      final currentTime = TimeOfDay.fromDateTime(currentDate);
      emit(state
          .updateCategories([]).updateDateAndTime(currentDate, currentTime));
    }
  }

  void _onSelectCategoryEvent(
      SelectCategoryEvent event, Emitter<AddTodoState> emit) {
    final selectedCategory = event.selectedCategory;
    if (!state.categories.contains(selectedCategory)) {
      return;
    }
    emit(state.updateSelectedCategory(selectedCategory));
  }
  Future<void> _onSaveTodoEvent(
      HandleSaveTodoEvent event, Emitter<AddTodoState> emit) async {
    final selectedCategory = state.selectedCategory;
    final selectedDate = state.selectedDate;
    final selectedTime = state.selectedTime;
    final title = state.titleTask;
    final notes = state.notes;

    if (title == null || title.isEmpty) {
      emit(state.updateValidationMessage(
          validationMessage: "Title is required!"));
      return;
    }
    if (selectedCategory == null) {
      emit(state.updateValidationMessage(
          validationMessage: "Category is required!"));
      return;
    }
    if (selectedDate == null) {
      emit(state.updateValidationMessage(
          validationMessage: "Date is required!"));
      return;
    }
    if (selectedTime == null) {
      emit(state.updateValidationMessage(
          validationMessage: "Time is required!"));
      return;
    }
    try {
      final newTodo = TodoItemModel(
        id: '',
        name: title,
        createTime: DateTime.now().toString(),
        isDone: false,
        category: selectedCategory,
        notes: notes,
      );
      await saveTodoUsecase(newTodo);
      emit(state.updateValidationMessage(validationMessage: "Todo added successfully!"));
    } catch (e) {
      emit(state.updateValidationMessage(validationMessage: "Error adding todo: $e"));
    }
  }

  void _onUpdateDateTimeEvent(
      UpdateDateTimeEvent event, Emitter<AddTodoState> emit) {
    emit(state.updateDateAndTime(event.newDate, event.newTime));
  }

  void _onUpdateDateEvent(UpdateDateEvent event, Emitter<AddTodoState> emit) {
    emit(state.updateDate(event.newDate));
  }

  void _onUpdateTimeEvent(UpdateTimeEvent event, Emitter<AddTodoState> emit) {
    emit(state.updateTime(event.newTime));
  }

  void _onUpdateTitleTaskEvent(
      UpdateTitleTaskEvent event, Emitter<AddTodoState> emit) {
    emit(state.updateTitleTask(event.titleTask));
  }

  void _onUpdateNotesEvent(UpdateNotesEvent event, Emitter<AddTodoState> emit) {
    emit(state.updateNotes(event.notes));
  }
}
