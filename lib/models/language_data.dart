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
];