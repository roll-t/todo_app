import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/service/core/core_service.dart';
import 'package:todo_app/core/service/public/data/entities/category_model.dart';

class CategoryService extends CoreService<CategoryModel> {

  @override
  String get collectionPath => 'category';

  @override
  CategoryModel fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    // Sử dụng CategoryModel.fromFirestore() để tạo đối tượng từ dữ liệu Firestore
    return CategoryModel.fromFirestore(doc.data()!, doc.id);
  }

  @override
  Map<String, dynamic> toFirestore(CategoryModel data) {
    // Sử dụng CategoryModel.toFirestore() để chuyển đối tượng thành Map
    return data.toFirestore();
  }

  @override
  Future<CategoryModel?> getById(String docId) async {
    try {
      final docSnapshot =
          await firestore.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) {
        return fromFirestore(docSnapshot);
      } else {
        print('Category with ID $docId does not exist.');
        return null;
      }
    } catch (e) {
      throw Exception('Error getting category by ID: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getAll() async {
    try {
      final querySnapshot = await firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Error getting categories: $e');
    }
  }

  @override
  Future<String> add(CategoryModel data) async {
    try {
      final docRef =
          await firestore.collection(collectionPath).add(toFirestore(data));
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }

  @override
  Future<void> update(String docId, CategoryModel data) async {
    try {
      await firestore.collection(collectionPath).doc(docId).update(toFirestore(data));
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }
}
