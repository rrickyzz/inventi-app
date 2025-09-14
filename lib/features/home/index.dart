import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:inventi/data/models/user_model.dart';
import 'package:inventi/data/repositories/firebase_repo.dart';
import 'package:inventi/data/services/firebase_auth.dart';
import 'package:inventi/data/services/firestore_service.dart';
import 'package:inventi/features/auth/screens/additional_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  final AuthRepository authRepository =
      AuthRepository(FirebaseAuthService(), FirestoreService());

  UserModel? userModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      authRepository.getCurrentUserData().then((userData) {
        setState(() {
          userModel = userData;
          isLoading = false;
        });
        if (userData != null && userData.userType == null) {
          inspect(userData);
          Get.to(() => const AdditionalInfoScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  subtitle: Text(
                      'User type: ${userModel?.userType ?? 'Not available'}'),
                  title: Text('Welcome, ${userModel?.firstName ?? 'User'}'),
                ),
                IconButton(
                    onPressed: () => authRepository.signOut(),
                    icon: const Icon(Icons.logout))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(children: []),
        ));
  }
}
