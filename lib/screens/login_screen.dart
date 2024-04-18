// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.onPress});

  final void Function()? onPress;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

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
              SizedBox(height: 50),
              Text('Welcome Back', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16)),
              SizedBox(height: 25),
              MyTextField(hintText: 'email', controller: emailEditingController),
              SizedBox(height: 10),
              MyTextField(hintText: 'password', controller: passwordEditingController),
              SizedBox(height: 25),
              MyButton(label: 'Login', onTap: login),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: onPress,
                child: Text('go to Regist'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void login() {}
}
