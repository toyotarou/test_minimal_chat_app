// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.onPress});

  final void Function()? onPress;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
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
  void register() {}
}
