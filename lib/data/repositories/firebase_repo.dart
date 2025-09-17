import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventi/data/models/location_model.dart';
import 'package:inventi/data/models/user_model.dart';
import 'package:inventi/data/services/firebase_auth.dart';
import 'package:inventi/data/services/firebase_realtime_service.dart';
import 'package:inventi/data/services/firestore_service.dart';

class AuthRepository {
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;
  AuthRepository(this._authService, this._firestoreService);

  Future<User?> registerUser(
      {required String email, required String password}) async {
    log('registerUser called in repo with email: $email, password: $password');
    final user =
        await _authService.createUser(email: email, password: password);
    return user;
  }

  Future loginUser({required String email, required String password}) async {
    final user = await _authService.loginUser(email: email, password: password);
    return user;
  }

  Future saveUserAdditionalInfo(UserModel user) async {
    await _firestoreService.saveUser(user);
  }

  Future<UserModel?> getCurrentUserData() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      return _firestoreService.getUser(currentUser.uid);
    }
    return null;
  }

  Future<void> signOut() async {
    await _authService.logout();
  }

  Stream<List<LocationModel>> get streamLocations =>
      FirebaseRealtimeDatabaseService().listenToLocations();

  User? get currentUser => _authService.currentUser;
}
