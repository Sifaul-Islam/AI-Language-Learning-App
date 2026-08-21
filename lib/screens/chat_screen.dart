import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';
import '../models/message_model.dart';
import '../providers/message_provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String language;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.language,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isCoolingDown = false;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<MessageProvider>().listenToMessages(widget.chatId);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

void _sendMessage() {
  final text = _messageController.text.trim();
  if (text.isEmpty || _isCoolingDown) return;

  _messageController.clear();
  context.read<MessageProvider>().sendMessage(
        chatId: widget.chatId,
        text: text,
        language: widget.language,
      );
  _scrollToBottom();

  // Brief cooldown to avoid hitting Gemini's free-tier rate limit
  setState(() => _isCoolingDown = true);
  Future.delayed(const Duration(seconds: 3), () {
    if (mounted) setState(() => _isCoolingDown = false);
  });
}
  @override
  Widget build(BuildContext context) {
    final messageProvider = context.watch<MessageProvider>();

    // Trigger auto-scroll when new messages arrive
    _scrollToBottom();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} Tutor'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Error State Banner with Retry option
          if (messageProvider.errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.red.shade100,
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      messageProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.read<MessageProvider>().retrySendMessage();
                    },
                    icon: const Icon(Icons.refresh, size: 18, color: Colors.red),
                    label: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          // Scrollable Message List
          Expanded(
            child: messageProvider.messages.isEmpty && !messageProvider.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Start a conversation in ${widget.language}!\nSay hello to your AI tutor.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    itemCount: messageProvider.messages.length +
                        (messageProvider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < messageProvider.messages.length) {
                        final message = messageProvider.messages[index];
                        return _MessageBubble(message: message);
                      } else {
                        // Loading Indicator while AI is responding
                        return const _AILoadingBubble();
                      }
                    },
                  ),
          ),

          // Text Input Field + Send Button
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Type your message in ${widget.language}...',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: messageProvider.isLoading || _isCoolingDown ? null : _sendMessage,
                    icon: messageProvider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageModel message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';
    final timeStr = DateFormat('hh:mm a').format(message.timestamp);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).primaryColor
              : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeStr,
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.black45,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AILoadingBubble extends StatefulWidget {
  const _AILoadingBubble();

  @override
  State<_AILoadingBubble> createState() => _AILoadingBubbleState();
}

class _AILoadingBubbleState extends State<_AILoadingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          ),
        ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    ...List.generate(3, (i) {
                      final delay = i * 0.2;
                      final t = (_controller.value - delay) % 1.0;
                      final bounce = t < 0.5 ? t * 2 : (1 - t) * 2;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Transform.translate(
                          offset: Offset(0, -6 * bounce),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    const Text(
                      'AI is typing',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                  ],
                );
              },
            ),
      ),
    );
  }
}