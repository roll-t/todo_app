import 'package:flutter/material.dart';
import 'package:todo_app/core/service/data/entities/category_model.dart';
import 'package:todo_app/features/home/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<TodoItemModel>> fetchTodos() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return [
        TodoItemModel(
          title: 'Complete project report',
          time: "9:00am",
          isDone: false,
          category: CategoryModel(
              id: "3",
              color: const Color.fromARGB(255, 155, 143, 35),
              icons: Icons.gif_box_rounded),
        ),
        TodoItemModel(
          title: 'Morning yoga session',
          time: "6:00am",
          isDone: false,
          category: CategoryModel(
              id: "2",
              color: const Color.fromARGB(255, 43, 136, 46),
              icons: Icons.calendar_month_rounded),
        ),
        TodoItemModel(
            title: 'Buy groceries',
            time: "2:00pm",
            isDone: false,
            category: CategoryModel(
                id: "2",
                color: const Color.fromARGB(255, 43, 136, 46),
                icons: Icons.calendar_month_rounded)),
        TodoItemModel(
            title: 'Read book for 30 minutes',
            time: "8:00pm",
            isDone: false,
            category: CategoryModel(
                id: "1", color: Colors.red, icons: Icons.message_rounded)),
        TodoItemModel(
            title: 'Complete work presentation',
            time: "1:00pm",
            isDone: true,
            category: CategoryModel(
                id: "2",
                color: const Color.fromARGB(255, 43, 136, 46),
                icons: Icons.calendar_month_rounded)),
        TodoItemModel(
            title: 'Dinner with friends',
            time: "7:00pm",
            isDone: true,
            category: CategoryModel(
                id: "3",
                color: const Color.fromARGB(255, 155, 143, 35),
                icons: Icons.gif_box_rounded)),
      ];
    } catch (e) {
      print("Error fetching data: $e");
      rethrow;
    }
  }
}
