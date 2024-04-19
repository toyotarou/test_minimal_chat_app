// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.onPress});

  final void Function()? onPress;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, size: 60, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 50),
              Text('Account Create', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16)),
              const SizedBox(height: 25),
              MyTextField(hintText: 'email', controller: emailEditingController),
              const SizedBox(height: 10),
              MyTextField(hintText: 'password', controller: passwordEditingController),
              const SizedBox(height: 10),
              MyTextField(hintText: 'confirm password', controller: confirmPasswordEditingController),
              const SizedBox(height: 25),
              MyButton(label: 'Register', onTap: register),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: onPress,
                child: const Text('go to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> register() async {
    final authService = AuthService();

    if (passwordEditingController.text == confirmPasswordEditingController.text) {
      try {
        await authService.signUpWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text);
      } catch (e) {
        await showDialog(

            ///TODO 変更できない
            context: _context,
            builder: (context) {
              return AlertDialog(title: Text(e.toString()));
            });
      }
    } else {
      await showDialog(

          ///TODO 変更できない
          context: _context,
          builder: (context) {
            return const AlertDialog(title: Text('password, confirm password, not match'));
          });
    }
  }
}
