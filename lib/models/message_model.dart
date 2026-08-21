import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String sender; // "user" or "ai"
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  // Convert a Firestore document into a MessageModel object
  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      id: id,
      sender: data['sender'] ?? 'user',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }


  // Convert a MessageModel object into a Map for writing to Firestore
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}