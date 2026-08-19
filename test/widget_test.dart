import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_language_learning_app/models/language_data.dart';
import 'package:ai_language_learning_app/models/message_model.dart';
void main() {
  test('LanguageOption model creates successfully', () {
    const option = LanguageOption(
      name: 'Spanish',
      flag: '🇪🇸',
      gradientColors: [Color(0xFFF5A623), Color(0xFFE63946)],
    );
    expect(option.name, equals('Spanish'));
    expect(option.flag, equals('🇪🇸'));
    expect(option.gradientColors.length, equals(2));
  });

  test('supportedLanguages list is not empty', () {
    expect(supportedLanguages.isNotEmpty, true);
  });

  test('Each supported language has valid fields', () {
    for (final lang in supportedLanguages) {
      expect(lang.name.isNotEmpty, true);
      expect(lang.flag.isNotEmpty, true);
      expect(lang.gradientColors.length, greaterThanOrEqualTo(2));
    }
  });

  test('MessageModel map conversion works', () {
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