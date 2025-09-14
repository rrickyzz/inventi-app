import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventi/common/constants/appcolor.dart';
import 'package:inventi/features/auth/controllers/auth_controller.dart';
import 'package:inventi/features/auth/screens/root_screen.dart';
import 'package:inventi/features/auth/screens/signin.dart';
import 'package:inventi/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inventi App',
      theme: appTheme,
      home: const RootPage(),
    );
  }
}
