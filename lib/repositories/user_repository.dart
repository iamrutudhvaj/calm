import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser({required String uid, required String email}) async {
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'streak': [],
    });
  }

  Future<bool> doesUserExist(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final doc = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return doc.data();
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  Future<void> updateStreak(String uid, List streak) async {
    await _firestore.collection('users').doc(uid).update({
      'streak': streak,
    });
  }

  Future<List<String>> getStreak(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.get('streak');
  }

  // stream of user data
  Stream<Map<String, dynamic>?> userStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      return doc.data();
    });
  }
}
