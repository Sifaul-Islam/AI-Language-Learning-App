import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String userId;
  final String language;
  final String title;
  final String lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.userId,
    required this.language,
    required this.title,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatModel(
      id: id,
      userId: data['userId'] ?? '',
      language: data['language'] ?? '',
      title: data['title'] ?? 'New Conversation',
      lastMessage: data['lastMessage'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'language': language,
      'title': title,
      'lastMessage': lastMessage,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}