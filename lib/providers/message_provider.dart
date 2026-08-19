import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/firestore_service.dart';
import '../services/gemini_service.dart';

class MessageProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final GeminiService _geminiService = GeminiService();

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

  bool _isSending = false;
  bool get isSending => _isSending;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void listenToMessages(String chatId) {
    _firestoreService.streamMessages(chatId).listen(
      (messageList) {
        _messages = messageList;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load messages: $error';
        notifyListeners();
      },
    );
  }

  Future<void> sendMessage({
    required String chatId,
    required String text,
    required String language,
  }) async {
    _isSending = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. Save user's message to Firestore
      final userMessage = MessageModel(
        id: '',
        sender: 'user',
        message: text,
        timestamp: DateTime.now(),
      );
      await _firestoreService.addMessage(chatId, userMessage);

      // 2. Get AI response from Gemini
      final aiText = await _geminiService.sendMessage(text, language);

      // 3. Save AI's response to Firestore
      final aiMessage = MessageModel(
        id: '',
        sender: 'ai',
        message: aiText,
        timestamp: DateTime.now(),
      );
      await _firestoreService.addMessage(chatId, aiMessage);

      // 4. Update chat's lastMessage/updatedAt
      await _firestoreService.updateChatMeta(chatId, lastMessage: aiText);

      _isSending = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to send message: $e';
      _isSending = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}