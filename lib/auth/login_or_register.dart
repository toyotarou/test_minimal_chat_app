import 'package:flutter/material.dart';
import 'package:test_minimal_chat_app/screens/login_screen.dart';
import 'package:test_minimal_chat_app/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginScreen = true;

  ///
  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onPress: togglePages,
      );
    } else {
      return RegisterScreen(
        onPress: togglePages,
      );
    }
  }
}
