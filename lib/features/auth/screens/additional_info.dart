import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:inventi/common/constants/appcolor.dart';
import 'package:inventi/common/constants/appinsets.dart';
import 'package:inventi/data/models/user_model.dart';
import 'package:inventi/data/repositories/firebase_repo.dart';
import 'package:inventi/data/services/firebase_auth.dart';
import 'package:inventi/data/services/firestore_service.dart';
import 'package:inventi/features/auth/controllers/auth_controller.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  String? _selectedUserType;
  UserModel? userModel;
  bool isLoading = false;

  final AuthRepository authRepository =
      AuthRepository(FirebaseAuthService(), FirestoreService());

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
          Get.to(() => const AdditionalInfoScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppInsets().screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Help us know you better by selecting your user type.',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),

              /// Radio buttons for user type
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Tenant"),
                value: "Tenant",
                groupValue: _selectedUserType,
                onChanged: (value) {
                  setState(() => _selectedUserType = value);
                },
              ),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Visitor"),
                value: "Visitor",
                groupValue: _selectedUserType,
                onChanged: (value) {
                  setState(() => _selectedUserType = value);
                },
              ),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Cleaner"),
                value: "Cleaner",
                groupValue: _selectedUserType,
                onChanged: (value) {
                  setState(() => _selectedUserType = value);
                },
              ),

              const Spacer(),

              /// Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedUserType == null
                      ? null
                      : () {
                          var user = userModel;
                          user?.userType = _selectedUserType;
                          authController.editInfo(user ?? UserModel());
                        },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
