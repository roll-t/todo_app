import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/service/core/core_service.dart';
import 'package:todo_app/core/service/public/data/entities/category_model.dart';
import 'package:todo_app/features/home/todo_list/data/entities/todo_item_model.dart';

class TodoService extends CoreService<TodoItemModel> {
  @override
  String get collectionPath => 'todo';

  @override
  TodoItemModel fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return TodoItemModel(
      id: doc.id,
      name: data['name'] as String,
      isDone: data['isDone'] as bool,
      createTime: data['createTimetime'] as String?,
      category: CategoryModel.fromFirestore(
        data['category'] as Map<String, dynamic>,
        '',
      ),
      notes: data['notes'] as String?,
    );
  }

  @override
  Map<String, dynamic> toFirestore(TodoItemModel data) {
    return {
      'name': data.name,
      'isDone': data.isDone,
      'createTimetime': data.createTime,
      'category': data.category.toFirestore(),
      'notes': data.notes,
    };
  }

  @override
  Future<TodoItemModel?> getById(String docId) async {
    try {
      final docSnapshot =
          await firestore.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) {
        return fromFirestore(docSnapshot);
      } else {
        print('Todo with ID $docId does not exist.');
        return null;
      }
    } catch (e) {
      throw Exception('Error getting todo by ID: $e');
    }
  }

  @override
  Future<List<TodoItemModel>> getAll() async {
    try {
      final querySnapshot = await firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Error getting todos: $e');
    }
  }

  @override
  Future<String> add(TodoItemModel data) async {
    try {
      final docRef =
          await firestore.collection(collectionPath).add(toFirestore(data));
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding todo: $e');
    }
  }

  @override
  Future<void> update(String docId, TodoItemModel data) async {
    try {
      await firestore
          .collection(collectionPath)
          .doc(docId)
          .update(toFirestore(data));
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting todo: $e');
    }
  }

  Future<void> completed(String docId) async {
    try {
      final docRef = firestore.collection(collectionPath).doc(docId);
      await docRef.update({
        "isDone": true,
      });
    } catch (e) {
      throw Exception('Error marking todo as completed: $e');
    }
  }
}
