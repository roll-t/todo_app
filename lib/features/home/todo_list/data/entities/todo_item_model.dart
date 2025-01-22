import 'package:todo_app/core/service/public/data/entities/category_model.dart';

class TodoItemModel {
  final String id;
  String name;
  bool isDone;
  final String? createTime;
  final CategoryModel category;
  final String? notes;

  TodoItemModel(
      {required this.id,
      required this.name,
      this.createTime,
      this.isDone = false,
      required this.category,
      this.notes});

  TodoItemModel copyWith(
      {String? name, bool? isDone, CategoryModel? category}) {
    return TodoItemModel(
        id: id,
        name: name ?? this.name,
        createTime: createTime,
        isDone: isDone ?? this.isDone,
        category: category ?? this.category,
        notes: notes);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'isDone': isDone,
      'createTimetime': createTime,
      "notes": notes
    };
  }
}
