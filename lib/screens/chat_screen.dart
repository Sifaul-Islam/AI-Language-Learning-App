import 'package:flutter/material.dart';

// Placeholder — Anni will build the real chat interface + Gemini integration
class ChatScreen extends StatelessWidget {
  final String chatId;
  final String language;

  const ChatScreen({super.key, required this.chatId, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat — $language')),
      body: Center(child: Text('Chat screen coming soon\nchatId: $chatId')),
    );
  }
}