import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CoreService<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CoreService();

  // Collection reference
  String get collectionPath;

  // Chuyển đổi từ Firestore
  T fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc);

  // Chuyển đối tượng T thành Map<String, dynamic> để lưu vào Firestore
  Map<String, dynamic> toFirestore(T data);

  // Lấy một document theo ID
  Future<T?> getById(String docId) async {
    try {
      final docSnapshot =
          await firestore.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) {
        return fromFirestore(docSnapshot);
      } else {
        print('Document with ID $docId does not exist.');
        return null;
      }
    } catch (e) {
      throw Exception('Error getting document by ID: $e');
    }
  }

  // Thêm một document mới
  Future<String> add(T data) async {
    try {
      final docRef =
          await firestore.collection(collectionPath).add(toFirestore(data));
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding document: $e');
    }
  }

  // Cập nhật một document
  Future<void> update(String docId, T data) async {
    try {
      await firestore
          .collection(collectionPath)
          .doc(docId)
          .update(toFirestore(data));
    } catch (e) {
      throw Exception('Error updating document: $e');
    }
  }

  // Xóa một document
  Future<void> delete(String docId) async {
    try {
      await firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  // Lấy tất cả các documents trong collection
  Future<List<T>> getAll() async {
    try {
      final querySnapshot = await firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Error getting documents: $e');
    }
  }
}
