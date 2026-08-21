import 'package:flutter/foundation.dart';
import '../models/message_model.dart';
import '../services/gemini_service.dart';
// import '../services/firestore_service.dart'; // add once Umama's is ready

class MessageProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  // final FirestoreService _firestoreService = FirestoreService();

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadMessages(String chatId) async {
    // Stub until Umama's FirestoreService exists:
    _messages = [];
    // Real version:
    // _messages = await _firestoreService.getMessages(chatId);
    notifyListeners();
  }

  Future<void> sendMessage(String chatId, String text, String language) async {
    final userMsg = MessageModel(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      message: text,
      timestamp: DateTime.now(),
    );
    _messages.add(userMsg);
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();


    // await _firestoreService.addMessage(chatId, userMsg);

    try {
      final aiText = await _geminiService.sendMessage(text, language);
      final aiMsg = MessageModel(
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'ai',
        message: aiText,
        timestamp: DateTime.now(),
      );
      _messages.add(aiMsg);
      // await _firestoreService.addMessage(chatId, aiMsg);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}