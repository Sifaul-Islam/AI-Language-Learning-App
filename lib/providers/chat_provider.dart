import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../services/firestore_service.dart';

class ChatProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  String? _selectedChatId;
  String? get selectedChatId => _selectedChatId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Call this once (e.g. in initState of Home screen) to start listening
  void listenToChats() {
    _firestoreService.streamChats().listen(
      (chatList) {
        _chats = chatList;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load conversations: $error';
        notifyListeners();
      },
    );
  }

  Future<String?> createNewChat(String language) async {
    _isLoading = true;
    notifyListeners();

    try {
      final chatId = await _firestoreService.createChat(language: language);
      _selectedChatId = chatId;
      _isLoading = false;
      notifyListeners();
      return chatId;
    } catch (e) {
      _errorMessage = 'Failed to create conversation: $e';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _firestoreService.deleteChat(chatId);
      if (_selectedChatId == chatId) {
        _selectedChatId = null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete conversation: $e';
      notifyListeners();
    }
  }

  void selectChat(String chatId) {
    _selectedChatId = chatId;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}