import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/service/api/data/entities/user_model.dart';
import 'package:todo_app/core/service/core/configs/firebase_exception.dart';
class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get collectionPath => 'users';

  Future<String> addUser(UserModel user) async {
    try {
      final docRef = await firestore.collection(collectionPath).add(user.toFirestore());
      return docRef.id;
    } catch (e) {
      throw FirestoreException(
        'Failed to add user.',
        'Ensure Firestore is properly configured.',
      );
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await firestore.collection(collectionPath).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc.data()!, doc.id);
      } else {
        throw FirestoreException(
          'User not found.',
          'Ensure the User ID is correct.',
        );
      }
    } catch (e) {
      throw FirestoreException(
        'Failed to fetch user.',
        'Check Firestore permissions or user existence.',
      );
    }
  }

  Future<void> updateUser(String userId, UserModel user) async {
    try {
      await firestore.collection(collectionPath).doc(userId).update(user.toFirestore());
    } catch (e) {
      throw FirestoreException(
        'Failed to update user.',
        'Ensure the User ID exists and Firestore rules are correct.',
      );
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await firestore.collection(collectionPath).doc(userId).delete();
    } catch (e) {
      throw FirestoreException(
        'Failed to delete user.',
        'Ensure the User ID exists.',
      );
    }
  }
}
