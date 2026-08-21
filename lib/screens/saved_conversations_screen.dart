import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../models/language_data.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class SavedConversationsScreen extends StatefulWidget {
  final bool embedded;
  const SavedConversationsScreen({super.key, this.embedded = false});

  @override
  State<SavedConversationsScreen> createState() =>
      _SavedConversationsScreenState();
}

class _SavedConversationsScreenState extends State<SavedConversationsScreen> {
  final Set<String> _pendingDeleteIds = {};

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);
    final difference = today.difference(date).inDays;

    if (difference == 0) return DateFormat('h:mm a').format(dt);
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return DateFormat('EEEE').format(dt);
    return DateFormat('MMM d').format(dt);
  }

  String _getFlag(String language) {
    final match = supportedLanguages.where((l) => l.name == language);
    return match.isNotEmpty ? match.first.flag : '🌐';
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final chats = chatProvider.chats
        .where((c) => !_pendingDeleteIds.contains(c.id))
        .toList();

    final listView = ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      itemCount: chats.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final chat = chats[index];
        final langOption = supportedLanguages.firstWhere(
          (l) => l.name == chat.language,
          orElse: () => const LanguageOption(
            name: '',
            flag: '🌐',
            gradientColors: [AppColors.primary, AppColors.primaryDark],
          ),
        );
        final gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: langOption.gradientColors,
        );

        return Dismissible(
          key: ValueKey(chat.id),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: const Icon(Icons.delete_rounded, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete conversation?'),
                    content: Text(
                        'This will permanently delete "${chat.language}" chat.'),
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
            setState(() {
              _pendingDeleteIds.add(chat.id);
            });
            context.read<ChatProvider>().deleteChat(chat.id);
          },
          child: Material(
            borderRadius: BorderRadius.circular(18),
            clipBehavior: Clip.antiAlias,
            child: Ink(
              decoration: BoxDecoration(gradient: gradient),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                          chatId: chat.id, language: chat.language),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _getFlag(chat.language),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.language,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              chat.lastMessage.isNotEmpty
                                  ? chat.lastMessage
                                  : 'Tap to continue',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _formatTimestamp(chat.updatedAt),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.chevron_right_rounded,
                          color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (widget.embedded) return listView;

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Conversations')),
      body: listView,
    );
  }
}