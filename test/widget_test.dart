import 'package:flutter_test/flutter_test.dart';
import 'package:ai_language_learning_app/models/language_data.dart';
import 'package:ai_language_learning_app/models/message_model.dart';

void main() {
  testWidgets('LanguageOption model creates successfully', (WidgetTester tester) async {
    const option = LanguageOption(name: 'Spanish', flag: '🇪🇸');
    expect(option.name, equals('Spanish'));
    expect(option.flag, equals('🇪🇸'));
  });

  testWidgets('MessageModel map conversion works', (WidgetTester tester) async {
    final now = DateTime.now();
    final message = MessageModel(
      id: '123',
      sender: 'user',
      message: 'Hello',
      timestamp: now,
    );

    final map = message.toMap();
    expect(map['sender'], equals('user'));
    expect(map['message'], equals('Hello'));
  });
}
