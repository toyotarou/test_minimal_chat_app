import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiverId, required this.receiverEmail});

  final String receiverId;
  final String receiverEmail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageEditingController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode focusNode = FocusNode();

  ScrollController scrollController = ScrollController();

  ///
  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), scrollDown);
      }
    });

    Future.delayed(const Duration(milliseconds: 500), scrollDown);
  }

  ///
  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  ///
  void scrollDown() =>
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text(widget.receiverEmail), backgroundColor: Colors.transparent, foregroundColor: Colors.grey, elevation: 0),
      body: Column(children: [Expanded(child: _buildMessageList()), _buildUserInput(), const SizedBox(height: 20)]),
    );
  }

  ///
  Future<void> sendMessage() async {
    await _chatService.sendMessage(receiverId: widget.receiverId, message: messageEditingController.text);

    messageEditingController.clear();
  }

  ///
  Widget _buildMessageList() {
    final senderId = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverId: widget.receiverId, senderId: senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        return ListView(
          controller: scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageListItem(doc: doc)).toList(),
        );
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
        Expanded(child: MyTextField(controller: messageEditingController, hintText: 'message', focusNode: focusNode)),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.5), shape: BoxShape.circle),
          child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
        ),
      ],
    );
  }
}
