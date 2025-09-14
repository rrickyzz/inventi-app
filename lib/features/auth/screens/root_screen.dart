import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventi/common/widgets/loading_indicator.dart';
import 'package:inventi/features/auth/screens/signin.dart';
import 'package:inventi/features/home/index.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Still loading Firebase auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: LoadingIndicator()),
          );
        }

        // User not signed in
        if (!snapshot.hasData) {
          return const SigninScreen();
        }

        // User is signed in
        return const HomeScreen();
      },
    );
  }
}
