// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_minimal_chat_app/screens/chat_screen.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';

// import '../services/auth/auth_service.dart';
//

import '../services/chat/chat_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();

  // AuthService _authService = AuthService();
  //

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  ///
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        return ListView(
          children: snapshot.data!.map((userData) {
            return _buildUserListItem(userData: userData);
          }).toList(),
        );
      },
    );
  }

  ///
  Widget _buildUserListItem({required Map<String, dynamic> userData}) {
    return UserTile(
      text: userData['email'],
      onTap: () {
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              email: userData['email'],
            ),
          ),
        );
      },
    );
  }
}
