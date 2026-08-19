import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent';

  Future<String> sendMessage(String userMessage, String language) async {
    const maxRetries = 2;
    int attempt = 0;

    while (true) {
      try {
        return await _makeRequest(userMessage, language);
      } catch (e) {
        attempt++;
        final isBusy = e.toString().contains('busy');
        if (isBusy && attempt <= maxRetries) {
          await Future.delayed(Duration(seconds: attempt * 2));
          continue;
        }
        rethrow;
      }
    }
  }

  Future<String> _makeRequest(String userMessage, String language) async {
    final url = Uri.parse(_baseUrl);

    final prompt =
        "You are a friendly $language language tutor. Respond in $language "
        "when appropriate, correct mistakes gently, and keep replies short. "
        "User: $userMessage";

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'X-goog-api-key': _apiKey,
            },
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
        if (response.statusCode == 503) {
          throw Exception('The AI tutor is a bit busy right now. Please try again.');
        } else if (response.statusCode == 429) {
          throw Exception('Too many requests. Please wait a moment and try again.');
        } else if (response.statusCode == 401 || response.statusCode == 403) {
          throw Exception('AI tutor authentication failed. Please check the API key.');
        } else {
          throw Exception('Something went wrong (error ${response.statusCode}). Please try again.');
        }
      }

      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      return text as String;
    } on http.ClientException {
      throw Exception('Network error — check your connection.');
    }
  }
}