import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // --- Chats ---

  Stream<List<ChatModel>> streamChats() {
    return _db
        .collection('chats')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<String> createChat({required String language}) async {
    final docRef = await _db.collection('chats').add({
      'language': language,
      'title': 'New Conversation',
      'lastMessage': '',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
    return docRef.id;
  }

  Future<void> deleteChat(String chatId) async {
    // Firestore does not cascade-delete subcollections, so we must
    // manually delete every message before deleting the chat itself.
    final messagesSnapshot = await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();

    final batch = _db.batch();
    for (final doc in messagesSnapshot.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(_db.collection('chats').doc(chatId));

    await batch.commit();
  }

  Future<void> updateChatMeta(String chatId, {required String lastMessage}) async {
    await _db.collection('chats').doc(chatId).update({
      'lastMessage': lastMessage,
      'updatedAt': Timestamp.now(),
    });
  }

  // --- Messages ---

  Stream<List<MessageModel>> streamMessages(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> addMessage(String chatId, MessageModel message) async {
    await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }
}
