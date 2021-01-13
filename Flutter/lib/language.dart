class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static Language en = Language(1, "US", "English", "en");
  static Language es = Language(2, "SP", "Spanish", "es");

  static List<Language> languageList() {
    return <Language>[
      Language(1, "US", "English", "en"),
      Language(2, "SP", "Spanish", "es"),
    ];
  }
}
