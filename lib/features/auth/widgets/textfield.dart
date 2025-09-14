import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  const AppTextfield(
      {super.key, this.obscureText = false, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
