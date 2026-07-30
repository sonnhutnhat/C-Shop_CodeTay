import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums/business_type.dart';
import '../models/enums/language.dart';

abstract final class SharedPreferencesHelper {
  static const _onboardedKey = 'is_onboarded';
  static const _languageKey = 'current_language';
  static const _businessTypeKey = 'business_type';

  static Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardedKey) ?? false;
  }

  static Future<void> setOnboarded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardedKey, value);
  }

  static Future<Language> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return Language.fromCode(prefs.getString(_languageKey));
  }

  static Future<void> setLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.code);
  }

  static Future<BusinessType> getBusinessType() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_businessTypeKey);
    return BusinessType.values.firstWhere(
      (item) => item.name == value,
      orElse: () => BusinessType.retail,
    );
  }

  static Future<void> setBusinessType(BusinessType value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_businessTypeKey, value.name);
  }
}
