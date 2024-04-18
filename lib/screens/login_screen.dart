// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.onPress});

  final void Function()? onPress;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, size: 60, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 50),
              Text('Welcome Back', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16)),
              const SizedBox(height: 25),
              MyTextField(hintText: 'email', controller: emailEditingController),
              const SizedBox(height: 10),
              MyTextField(hintText: 'password', controller: passwordEditingController),
              const SizedBox(height: 25),
              MyButton(label: 'Login', onTap: login),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: onPress,
                child: const Text('go to Regist'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> login() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text);
    } catch (e) {
      await showDialog(
          context: _context,
          builder: (context) {
            return AlertDialog(title: Text(e.toString()));
          });
    }
  }
}
