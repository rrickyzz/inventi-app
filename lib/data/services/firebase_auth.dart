import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUser(
      {required String email, required String password}) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return cred.user;
  }

  Future<User?> loginUser(
      {required String email, required String password}) async {
    UserCredential cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }
    /// --- Logout ---
  Future<void> logout() async {
    await _auth.signOut();
  }


  User? get currentUser => _auth.currentUser;
}
