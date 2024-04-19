// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('HomeScreen'), backgroundColor: Colors.transparent, foregroundColor: Colors.grey, elevation: 0),
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

        return ListView(children: snapshot.data!.map((userData) => _buildUserListItem(userData: userData)).toList());
      },
    );
  }

  ///
  Widget _buildUserListItem({required Map<String, dynamic> userData}) {
    if (userData['email'] == _authService.getCurrentUser()!.email) {
      return Container();
    } else {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            _context,
            MaterialPageRoute(builder: (context) => ChatScreen(receiverId: userData['uid'], receiverEmail: userData['email'])),
          );
        },
      );
    }
  }
}
