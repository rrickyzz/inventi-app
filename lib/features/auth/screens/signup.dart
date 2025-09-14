import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventi/common/constants/appcolor.dart';
import 'package:inventi/common/constants/appinsets.dart';
import 'package:inventi/features/auth/controllers/auth_controller.dart';
import 'package:inventi/features/auth/widgets/textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Container(
          height: Get.size.height * .7, // taller to fit more fields
          padding: AppInsets().screenPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Create a new account to get started.',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),

                /// Input fields
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: AppTextfield(
                      controller: authController.firstNameController,
                      labelText: 'First Name'),
                ),
                const SizedBox(height: 12),
                AppTextfield(
                  controller: authController.lastNameController,
                  labelText: 'Last Name',
                ),
                const SizedBox(height: 12),
                AppTextfield(
                  controller: authController.signupEmailController,
                  labelText: 'Email',
                ),
                const SizedBox(height: 12),
                AppTextfield(
                  controller: authController.signupPasswordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                AppTextfield(
                  controller: authController.confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),

                /// Button
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.signUp();
                    },
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      /// Bottom navigation text
      bottomNavigationBar: Padding(
        padding: AppInsets().screenPadding,
        child: SafeArea(
          child: TextButton(
            onPressed: () {
              // TODO: Navigate back to SignInScreen
              Get.back();
            },
            child: RichText(
              text: const TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: AppColors.textSecondary),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
