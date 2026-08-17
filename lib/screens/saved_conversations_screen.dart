import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class SavedConversationsScreen extends StatelessWidget {
  final bool embedded;
  const SavedConversationsScreen({super.key, this.embedded = false});

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);
    final difference = today.difference(date).inDays;

    if (difference == 0) {
      return 'Today, ${DateFormat('h:mm a').format(dt)}';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat('EEEE').format(dt); // e.g. "Monday"
    } else {
      return DateFormat('MMM d, y').format(dt); // e.g. "Aug 10, 2026"
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final chats = chatProvider.chats;

    final listView = ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Dismissible(
          key: ValueKey(chat.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete conversation?'),
                    content: Text('This will permanently delete "${chat.title}".'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ) ??
                false;
          },
          onDismissed: (direction) {
            context.read<ChatProvider>().deleteChat(chat.id);
          },
          child: ListTile(
            title: Text(chat.title),
            subtitle: Text(
              '${chat.language} • ${chat.lastMessage}\n${_formatTimestamp(chat.updatedAt)}',
            ),
            isThreeLine: true,
            onTap: () {
              // TODO: navigate to ChatScreen with chat.id once it exists
            },
          ),
        );
      },
    );

    if (embedded) {
      return listView;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Conversations')),
      body: listView,
    );
  }
}