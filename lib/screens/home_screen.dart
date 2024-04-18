import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  ///
  void logout() => AuthService().signOut();
}
