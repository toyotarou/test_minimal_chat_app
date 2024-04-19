// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onPress});

  final void Function()? onPress;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        child: SingleChildScrollView(
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
                onPressed: widget.onPress,
                child: const Text('go to Regist'),
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          emailEditingController.text = 'toyoda@test.com';
                          passwordEditingController.text = 'password';
                        });
                      },
                      child: const Text('toyoda'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          emailEditingController.text = 'flutter@test.com';
                          passwordEditingController.text = 'password';
                        });
                      },
                      child: const Text('flutter'),
                    ),
                  ],
                ),
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

          ///TODO 変更できない
          context: _context,
          builder: (context) {
            return AlertDialog(title: Text(e.toString()));
          });
    }
  }
}
