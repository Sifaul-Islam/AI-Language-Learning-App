import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/firestore_service.dart';
import '../services/gemini_service.dart';

class MessageProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final GeminiService _geminiService = GeminiService();

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _lastFailedText;
  String? _lastFailedChatId;
  String? _lastFailedLanguage;

  /// Start listening to live Firestore message updates for [chatId]
  void listenToMessages(String chatId) {
    _messages = [];
    _errorMessage = null;
    notifyListeners();

    try {
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
    } catch (e) {
      _errorMessage = 'Firestore error: $e';
    }
  }

  /// Send user message to Firestore, trigger Gemini AI API, and save AI response
  Future<void> sendMessage({
    required String chatId,
    required String text,
    required String language,
  }) async {
    if (text.trim().isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. Save user message to Firestore
      final userMessage = MessageModel(
        id: '',
        sender: 'user',
        message: text.trim(),
        timestamp: DateTime.now(),
      );

      await _firestoreService.addMessage(chatId, userMessage);
      await _firestoreService.updateChatMeta(chatId, lastMessage: text.trim());

      // 2. Fetch AI response from Gemini API
      final aiReply = await _geminiService.sendMessage(text.trim(), language);

      // 3. Save AI message to Firestore
      final aiMessage = MessageModel(
        id: '',
        sender: 'ai',
        message: aiReply,
        timestamp: DateTime.now(),
      );

      await _firestoreService.addMessage(chatId, aiMessage);
      await _firestoreService.updateChatMeta(chatId, lastMessage: aiReply);
    } catch (e) {
      _lastFailedChatId = chatId;
      _lastFailedText = text;
      _lastFailedLanguage = language;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Retry sending the last failed message to Gemini AI
  Future<void> retrySendMessage() async {
    if (_lastFailedChatId != null &&
        _lastFailedText != null &&
        _lastFailedLanguage != null) {
      final chatId = _lastFailedChatId!;
      final text = _lastFailedText!;
      final language = _lastFailedLanguage!;

      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        final aiReply = await _geminiService.sendMessage(text, language);

        final aiMessage = MessageModel(
          id: '',
          sender: 'ai',
          message: aiReply,
          timestamp: DateTime.now(),
        );

        await _firestoreService.addMessage(chatId, aiMessage);
        await _firestoreService.updateChatMeta(chatId, lastMessage: aiReply);

        _lastFailedChatId = null;
        _lastFailedText = null;
        _lastFailedLanguage = null;
      } catch (e) {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}