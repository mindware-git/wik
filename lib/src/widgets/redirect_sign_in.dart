import 'package:flutter/material.dart';

class ReditectSignIn extends StatelessWidget {
  const ReditectSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, '/sign-in'));
    return const SizedBox();
  }
}
