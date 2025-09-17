import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventi/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
 
  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _db.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return null;
  }


}
