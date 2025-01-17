import 'package:todo_app/core/service/data/entities/category_model.dart';

class TodoItemModel {
  String title;
  bool isDone;
  final String? time;
  final CategoryModel category;

  TodoItemModel({required this.title, this.time, this.isDone = false,required this.category});

  TodoItemModel copyWith({String? title, bool? isDone, CategoryModel? category}) {
    return TodoItemModel(
      title: title ?? this.title,
      time: time,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'time': time,
      
    };
  }
}
