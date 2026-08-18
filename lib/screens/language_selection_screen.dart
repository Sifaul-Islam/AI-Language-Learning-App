import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/language_data.dart';
import '../providers/chat_provider.dart';
import 'chat_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Target Language'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: supportedLanguages.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final lang = supportedLanguages[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Text(
                lang.flag,
                style: const TextStyle(fontSize: 32),
              ),
              title: Text(
                lang.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Practice speaking and writing in ${lang.name}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final chatProvider = context.read<ChatProvider>();
                final chatId = await chatProvider.createNewChat(lang.name);

                if (chatId != null && context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatId: chatId,
                        language: lang.name,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}