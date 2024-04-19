import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_minimal_chat_app/components/my_text_field.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.receiverId, required this.receiverEmail});

  final String receiverId;
  final String receiverEmail;

  final TextEditingController messageEditingController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ///
  Future<void> sendMessage() async {
    await _chatService.sendMessage(receiverId: receiverId, message: messageEditingController.text);

    messageEditingController.clear();
  }

  ///
  Widget _buildMessageList() {
    final senderId = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverId: receiverId, senderId: senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return _buildMessageListItem(doc: doc);
          }).toList(),
        );
      },
    );
  }

  ///
  Widget _buildMessageListItem({required DocumentSnapshot doc}) {
    final data = doc.data()! as Map<String, dynamic>;

    return Text(data['message']);
  }

  ///
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(child: MyTextField(controller: messageEditingController, hintText: 'message')),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
      ],
    );
  }
}
