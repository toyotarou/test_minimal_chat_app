import 'package:flutter/material.dart';
import 'package:test_minimal_chat_app/screens/setting_screen.dart';

import '../auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              ListTile(
                title: const Text('HOME'),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('SETTING'),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              title: const Text('LOGOUT'),
              leading: const Icon(Icons.logout),
              onTap: () {
                AuthService().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
