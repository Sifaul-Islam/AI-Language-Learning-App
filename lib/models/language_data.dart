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

final List<LanguageOption> supportedLanguages = [
  const LanguageOption(name: 'Spanish', flag: '🇪🇸', gradientColors: [Color(0xFFF5A623), Color(0xFFE63946)]),
  const LanguageOption(name: 'French', flag: '🇫🇷', gradientColors: [Color(0xFF3F7FE0), Color(0xFFE63946)]),
  const LanguageOption(name: 'Japanese', flag: '🇯🇵', gradientColors: [Color(0xFFE63946), Color(0xFFB92D3A)]),
  const LanguageOption(name: 'German', flag: '🇩🇪', gradientColors: [Color(0xFF3A3A3A), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Korean', flag: '🇰🇷', gradientColors: [Color(0xFF3F7FE0), Color(0xFF9B7EF0)]),
  const LanguageOption(name: 'Italian', flag: '🇮🇹', gradientColors: [Color(0xFF2DBE91), Color(0xFFE63946)]),
  const LanguageOption(name: 'Portuguese', flag: '🇵🇹', gradientColors: [Color(0xFF2DBE91), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Mandarin Chinese', flag: '🇨🇳', gradientColors: [Color(0xFFE63946), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Russian', flag: '🇷🇺', gradientColors: [Color(0xFF3F7FE0), Color(0xFFE63946)]),
  const LanguageOption(name: 'Arabic', flag: '🇸🇦', gradientColors: [Color(0xFF2DBE91), Color(0xFF3A3A3A)]),
  const LanguageOption(name: 'Hindi', flag: '🇮🇳', gradientColors: [Color(0xFFF5A623), Color(0xFF2DBE91)]),
  const LanguageOption(name: 'Bengali', flag: '🇧🇩', gradientColors: [Color(0xFF2DBE91), Color(0xFFB92D3A)]),
  const LanguageOption(name: 'Turkish', flag: '🇹🇷', gradientColors: [Color(0xFFE63946), Color(0xFFB92D3A)]),
  const LanguageOption(name: 'Dutch', flag: '🇳🇱', gradientColors: [Color(0xFFE63946), Color(0xFF3F7FE0)]),
  const LanguageOption(name: 'Greek', flag: '🇬🇷', gradientColors: [Color(0xFF3F7FE0), Color(0xFF6FA8E8)]),
  const LanguageOption(name: 'Polish', flag: '🇵🇱', gradientColors: [Color(0xFFE63946), Color(0xFFB0B0B0)]),
  const LanguageOption(name: 'Swedish', flag: '🇸🇪', gradientColors: [Color(0xFF3F7FE0), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Vietnamese', flag: '🇻🇳', gradientColors: [Color(0xFFE63946), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Thai', flag: '🇹🇭', gradientColors: [Color(0xFFE63946), Color(0xFF3F7FE0)]),
  const LanguageOption(name: 'Indonesian', flag: '🇮🇩', gradientColors: [Color(0xFFE63946), Color(0xFFB0B0B0)]),
  const LanguageOption(name: 'Hebrew', flag: '🇮🇱', gradientColors: [Color(0xFF3F7FE0), Color(0xFF9B7EF0)]),
  const LanguageOption(name: 'Ukrainian', flag: '🇺🇦', gradientColors: [Color(0xFF3F7FE0), Color(0xFFE0A800)]),
  const LanguageOption(name: 'Czech', flag: '🇨🇿', gradientColors: [Color(0xFF3F7FE0), Color(0xFFE63946)]),
  LanguageOption(name: 'Finnish', flag: '🇫🇮', gradientColors: [const Color(0xFF3F7FE0), const Color(0xFFFFFFFF).withValues(alpha: 0.9)]),
  const LanguageOption(name: 'Danish', flag: '🇩🇰', gradientColors: [Color(0xFFE63946), Color(0xFFB92D3A)]),
  const LanguageOption(name: 'Norwegian', flag: '🇳🇴', gradientColors: [Color(0xFFE63946), Color(0xFF3F7FE0)]),
];