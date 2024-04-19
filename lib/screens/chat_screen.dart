import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';
import '../components/my_text_field.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text(receiverEmail), backgroundColor: Colors.transparent, foregroundColor: Colors.grey, elevation: 0),
      body: Column(children: [Expanded(child: _buildMessageList()), _buildUserInput(), const SizedBox(height: 20)]),
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

        return ListView(children: snapshot.data!.docs.map((doc) => _buildMessageListItem(doc: doc)).toList());
      },
    );
  }

  ///
  Widget _buildMessageListItem({required DocumentSnapshot doc}) {
    final data = doc.data()! as Map<String, dynamic>;

    final isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)],
      ),
    );
  }

  ///
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(child: MyTextField(controller: messageEditingController, hintText: 'message')),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.5), shape: BoxShape.circle),
          child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
        ),
      ],
    );
  }
}
