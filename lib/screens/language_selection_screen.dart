import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../models/language_data.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: ListView(
        children: supportedLanguages.map((lang) {
          return ListTile(
            leading: Text(lang.flag, style: const TextStyle(fontSize: 24)),
            title: Text(lang.name),
            onTap: () async {
              final chatId = await context
                  .read<ChatProvider>()
                  .createNewChat(lang.name);
              if (chatId != null && context.mounted) {
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}