import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isCurrentUser});

  final String message;
  final bool isCurrentUser;

  ///
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? isDarkMode
                ? Colors.green.shade500
                : Colors.grey.shade500
            : isDarkMode
                ? Colors.grey.shade800
                : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
