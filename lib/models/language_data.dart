import 'package:flutter/material.dart';

class LanguageOption {
  final String name;
  final String flag; // emoji flag, keeps UI simple with no image assets
  final List<Color> gradientColors;

  const LanguageOption({
    required this.name,
    required this.flag,
    required this.gradientColors,
  });
}

const List<LanguageOption> supportedLanguages = [
  LanguageOption(name: 'Spanish', flag: '🇪🇸', gradientColors: [Color(0xFFFF9F6B), Color(0xFFE8611F)]),
  LanguageOption(name: 'French', flag: '🇫🇷', gradientColors: [Color(0xFF6FA8F5), Color(0xFF2E6FD9)]),
  LanguageOption(name: 'Japanese', flag: '🇯🇵', gradientColors: [Color(0xFFEF7A8B), Color(0xFFC7304A)]),
  LanguageOption(name: 'German', flag: '🇩🇪', gradientColors: [Color(0xFF6B6B6B), Color(0xFF2E2E2E)]),
  LanguageOption(name: 'Korean', flag: '🇰🇷', gradientColors: [Color(0xFFA78BF0), Color(0xFF6E4CC9)]),
  LanguageOption(name: 'Italian', flag: '🇮🇹', gradientColors: [Color(0xFF52D6A6), Color(0xFF1E9E74)]),
  LanguageOption(name: 'Portuguese', flag: '🇵🇹', gradientColors: [Color(0xFF3ECFC6), Color(0xFF16948C)]),
  LanguageOption(name: 'Mandarin Chinese', flag: '🇨🇳', gradientColors: [Color(0xFFFF7A6E), Color(0xFFD9432F)]),
  LanguageOption(name: 'Russian', flag: '🇷🇺', gradientColors: [Color(0xFF7C93F0), Color(0xFF3F58C9)]),
  LanguageOption(name: 'Arabic', flag: '🇸🇦', gradientColors: [Color(0xFF4BC98A), Color(0xFF1D8F5B)]),
  LanguageOption(name: 'Hindi', flag: '🇮🇳', gradientColors: [Color(0xFFFFB84D), Color(0xFFE08900)]),
  LanguageOption(name: 'Bengali', flag: '🇧🇩', gradientColors: [Color(0xFF4FCB8C), Color(0xFF1B8F58)]),
  LanguageOption(name: 'Turkish', flag: '🇹🇷', gradientColors: [Color(0xFFFF7E7E), Color(0xFFD93A3A)]),
  LanguageOption(name: 'Dutch', flag: '🇳🇱', gradientColors: [Color(0xFFFF9457), Color(0xFFE0651A)]),
  LanguageOption(name: 'Greek', flag: '🇬🇷', gradientColors: [Color(0xFF6EC1F0), Color(0xFF2B8FD1)]),
  LanguageOption(name: 'Polish', flag: '🇵🇱', gradientColors: [Color(0xFFFF8FA3), Color(0xFFE0405C)]),
  LanguageOption(name: 'Swedish', flag: '🇸🇪', gradientColors: [Color(0xFF6FA8F5), Color(0xFF3568D4)]),
  LanguageOption(name: 'Vietnamese', flag: '🇻🇳', gradientColors: [Color(0xFFFFC24D), Color(0xFFE09800)]),
  LanguageOption(name: 'Thai', flag: '🇹🇭', gradientColors: [Color(0xFF8B7EF0), Color(0xFF5A47C9)]),
  LanguageOption(name: 'Indonesian', flag: '🇮🇩', gradientColors: [Color(0xFFFF7E7E), Color(0xFFD93A3A)]),
  LanguageOption(name: 'Hebrew', flag: '🇮🇱', gradientColors: [Color(0xFF7FB8F5), Color(0xFF3A7FD4)]),
  LanguageOption(name: 'Ukrainian', flag: '🇺🇦', gradientColors: [Color(0xFFFFD166), Color(0xFFE0A400)]),
  LanguageOption(name: 'Czech', flag: '🇨🇿', gradientColors: [Color(0xFF6FA8F5), Color(0xFF2E6FD9)]),
  LanguageOption(name: 'Finnish', flag: '🇫🇮', gradientColors: [Color(0xFF8FD1E8), Color(0xFF3F9FC2)]),
  LanguageOption(name: 'Danish', flag: '🇩🇰', gradientColors: [Color(0xFFFF7E7E), Color(0xFFD93A3A)]),
  LanguageOption(name: 'Norwegian', flag: '🇳🇴', gradientColors: [Color(0xFF6FA8F5), Color(0xFF2E6FD9)]),
];