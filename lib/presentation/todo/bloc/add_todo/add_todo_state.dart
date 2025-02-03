import 'package:flutter/material.dart';
import 'package:todo_app/core/service/data/categories/entities/category_model.dart';

class AddTodoState {
  // xem copywith state
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? titleTask;
  final String? notes;
  final String? validationMessage;
  final bool? isWaiting;

  AddTodoState({
    required this.categories,
    this.selectedCategory,
    this.selectedDate,
    this.selectedTime,
    this.titleTask,
    this.notes,
    this.validationMessage,
    this.isWaiting,
  });

  AddTodoState copyWith({
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? titleTask,
    String? notes,
    String? validationMessage,
    bool? isWaiting,
  }) {
    return AddTodoState(
      categories:
          categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      titleTask: titleTask ?? this.titleTask,
      notes: notes ?? this.notes,
      validationMessage: validationMessage ?? this.validationMessage,
      isWaiting: isWaiting ?? this.isWaiting,
    );
  }

  AddTodoState updateCategories(List<CategoryModel> categories) {
    return AddTodoState(
      titleTask: titleTask,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }

  AddTodoState updateSelectedCategory(CategoryModel? selectedCategory) {
    return AddTodoState(
      titleTask: titleTask,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }

  AddTodoState updateTitleTask(String title) {
    return AddTodoState(
      titleTask: title,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }

  AddTodoState updateNotes(String notes) {
    return AddTodoState(
      notes: notes,
      titleTask: titleTask,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }

  AddTodoState updateDateAndTime(DateTime newDate, TimeOfDay newTime) {
    return AddTodoState(
      titleTask: titleTask,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: newDate,
      selectedTime: newTime,
    );
  }

  AddTodoState updateDate(DateTime newDate) {
    return AddTodoState(
      titleTask: titleTask,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: newDate,
      selectedTime: selectedTime,
    );
  }

  AddTodoState updateTime(TimeOfDay newTime) {
    return AddTodoState(
      titleTask: titleTask,
      notes: notes,
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: newTime,
    );
  }

  AddTodoState updateValidationMessage({String? validationMessage}) {
    return AddTodoState(
      categories: categories,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      titleTask: titleTask,
      notes: notes,
      validationMessage: validationMessage ?? this.validationMessage,
    );
  }
}
