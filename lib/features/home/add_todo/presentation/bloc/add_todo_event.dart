import 'package:flutter/material.dart';
import 'package:todo_app/core/service/public/data/entities/category_model.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

abstract class AddTodoEvent {}

class InitializeAddTodoEvent extends AddTodoEvent {}

class SelectCategoryEvent extends AddTodoEvent {
  final CategoryModel selectedCategory;
  SelectCategoryEvent(this.selectedCategory);
}

class UpdateDateTimeEvent extends AddTodoEvent {
  final DateTime newDate;
  final TimeOfDay newTime;
  UpdateDateTimeEvent({required this.newDate, required this.newTime});
}

class UpdateDateEvent extends AddTodoEvent {
  final DateTime newDate;
  UpdateDateEvent({required this.newDate});
}

class UpdateTimeEvent extends AddTodoEvent {
  final TimeOfDay newTime;
  UpdateTimeEvent({required this.newTime});
}

class UpdateTitleTaskEvent extends AddTodoEvent {
  final String titleTask;
  UpdateTitleTaskEvent({required this.titleTask});
}

class UpdateNotesEvent extends AddTodoEvent {
  final String notes;
  UpdateNotesEvent({required this.notes});
}

class AddEvent extends AddTodoEvent {
  final TodoItemModel todo;

  AddEvent(this.todo);
}


class HandleSaveTodoEvent extends AddTodoEvent {}

class Loading extends AddTodoEvent {}
