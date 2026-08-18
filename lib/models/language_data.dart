class LanguageOption {
  final String name;
  final String flag; // emoji flag, keeps UI simple with no image assets

  const LanguageOption({required this.name, required this.flag});
}

const List<LanguageOption> supportedLanguages = [
  LanguageOption(name: 'Spanish', flag: '🇪🇸'),
  LanguageOption(name: 'French', flag: '🇫🇷'),
  LanguageOption(name: 'Japanese', flag: '🇯🇵'),
  LanguageOption(name: 'German', flag: '🇩🇪'),
  LanguageOption(name: 'Korean', flag: '🇰🇷'),
  LanguageOption(name: 'Italian', flag: '🇮🇹'),
  LanguageOption(name: 'Portuguese', flag: '🇵🇹'),
  LanguageOption(name: 'Mandarin Chinese', flag: '🇨🇳'),
  LanguageOption(name: 'Russian', flag: '🇷🇺'),
  LanguageOption(name: 'Arabic', flag: '🇸🇦'),
  LanguageOption(name: 'Hindi', flag: '🇮🇳'),
  LanguageOption(name: 'Bengali', flag: '🇧🇩'),
  LanguageOption(name: 'Turkish', flag: '🇹🇷'),
  LanguageOption(name: 'Dutch', flag: '🇳🇱'),
  LanguageOption(name: 'Greek', flag: '🇬🇷'),
  LanguageOption(name: 'Polish', flag: '🇵🇱'),
  LanguageOption(name: 'Swedish', flag: '🇸🇪'),
  LanguageOption(name: 'Vietnamese', flag: '🇻🇳'),
  LanguageOption(name: 'Thai', flag: '🇹🇭'),
  LanguageOption(name: 'Indonesian', flag: '🇮🇩'),
  LanguageOption(name: 'Hebrew', flag: '🇮🇱'),
  LanguageOption(name: 'Ukrainian', flag: '🇺🇦'),
  LanguageOption(name: 'Czech', flag: '🇨🇿'),
  LanguageOption(name: 'Finnish', flag: '🇫🇮'),
  LanguageOption(name: 'Danish', flag: '🇩🇰'),
  LanguageOption(name: 'Norwegian', flag: '🇳🇴'),
];