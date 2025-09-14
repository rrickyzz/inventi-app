import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventi/common/utils/loading.dart';
import 'package:inventi/data/models/user_model.dart';
import 'package:inventi/data/repositories/firebase_repo.dart';
import 'package:inventi/data/services/firebase_auth.dart';
import 'package:inventi/data/services/firestore_service.dart';
import 'package:inventi/features/home/index.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository =
      AuthRepository(FirebaseAuthService(), FirestoreService());

  /// --- Sign In ---
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// --- Sign Up ---
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// --- State ---
  var isLoading = false.obs;

  /// --- Sign In ---
  Future<void> signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return;
    }

    isLoading.value = true;
    try {
      await OverlayUtils.runWithOverlay(asyncFunction: () async {
        final user = await authRepository.loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (user == null) {
          Get.snackbar("Error", "Invalid email or password");
        } else {
          log("User signed in: ${user.email}");
          // No navigation needed; RootPage handles it
        }
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// --- Sign Out ---
  Future<void> signOut() async {
    try {
      OverlayUtils.runWithOverlay(asyncFunction: () async {
        await authRepository.signOut();
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// --- Sign Up ---
  Future<void> signUp() async {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        signupEmailController.text.trim().isEmpty ||
        signupPasswordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (signupPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    try {
      await OverlayUtils.runWithOverlay(asyncFunction: () async {
        // Register user
        final user = await authRepository.registerUser(
          email: signupEmailController.text.trim(),
          password: signupPasswordController.text.trim(),
        );

        if (user != null) {
          // Save basic additional info
          final userModel = UserModel(
            uid: user.uid,
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: user.email,
          );
          await authRepository.saveUserAdditionalInfo(userModel);

          log("User registered: ${user.email}");
          // No navigation needed; RootPage handles it
        } else {
          log("Registration failed");
          Get.snackbar("Error", "Registration failed");
        }
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// --- Save User Type ---
  Future<void> editInfo(UserModel user) async {
    if (user.userType == null) {
      Get.snackbar("Error", "Please select a user type");
      return;
    }

    isLoading.value = true;
    try {
      await OverlayUtils.runWithOverlay(asyncFunction: () async {
        await authRepository.saveUserAdditionalInfo(user);
      });
      Get.to(() => const HomeScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Cleanup controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
