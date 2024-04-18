import 'package:flutter/material.dart';
import 'package:test_minimal_chat_app/screens/register_screen.dart';

import 'auth/login_or_register.dart';
import 'themes/light_mode.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginOrRegister(),
      theme: lightMode,
    );
  }
}
