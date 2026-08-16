import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

  Future<String> sendMessage(String userMessage, String language) async {
    final url = Uri.parse('$_baseUrl?key=$_apiKey');

    final prompt =
        "You are a friendly $language language tutor. Respond in $language "
        "when appropriate, correct mistakes gently, and keep replies short. "
        "User: $userMessage";

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "contents": [
                {
                  "parts": [
                    {"text": prompt}
                  ]
                }
              ]
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw Exception('Gemini API error: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      return text as String;
    } on http.ClientException {
      throw Exception('Network error — check your connection.');
    } catch (e) {
      throw Exception('Failed to get AI response: $e');
    }
  }
}