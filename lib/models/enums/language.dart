import 'dart:ui';

enum Language {
  vietnamese,
  english;

  String get code => switch (this) {
        Language.vietnamese => 'vi',
        Language.english => 'en',
      };

  Locale get locale => Locale(code);

  static Language fromCode(String? code) {
    return code == Language.english.code
        ? Language.english
        : Language.vietnamese;
  }
}
