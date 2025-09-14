import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:inventi/common/constants/appcolor.dart';
import 'package:inventi/common/constants/appinsets.dart';
import 'package:inventi/features/auth/controllers/auth_controller.dart';
import 'package:inventi/features/auth/screens/signup.dart';
import 'package:inventi/features/auth/widgets/textfield.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Container(
          height: Get.size.height * .4,
          padding: AppInsets().screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('Welcome back! Please sign in to your account.',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: AppTextfield(
                  controller: authController.emailController,
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 12),
              AppTextfield(
                controller: authController.passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    authController.signIn();
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppInsets().screenPadding,
        child: SafeArea(
          child: TextButton(
            onPressed: () => Get.to(() => const SignupScreen()),
            child: RichText(
                text: const TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(color: AppColors.textSecondary),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
