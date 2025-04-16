import 'package:avicultura_app/common/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProfile(UserModel user) async {
    try {
      if (user.id == null) {
        throw 'User ID cannot be null';
      }
      
      await _firestore.collection('users').doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'aviaryName': user.aviaryName,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error saving user profile: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).get();
      
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return UserModel(
          id: userId,
          email: data['email'],
          name: data['name'],
          aviaryName: data['aviaryName'],
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      rethrow;
    }
  }
}