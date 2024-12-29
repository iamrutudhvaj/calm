import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getProfile() async {
    final doc = await _firestore.collection('users').doc('profile').get();
    return doc.data()!;
  }

  Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> profile) async {
    await _firestore.collection('users').doc('profile').update(profile);
    final doc = await _firestore.collection('users').doc('profile').get();
    return doc.data()!;
  }
}
