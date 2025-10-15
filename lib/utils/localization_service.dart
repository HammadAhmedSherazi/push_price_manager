import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/shared_preferences.dart';

class LocalizationService {
  final Locale locale;
  static Map<String, String> _localizedStrings = {};

  LocalizationService(this.locale);

  static LocalizationService? of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService);
  }

  static const LocalizationsDelegate<LocalizationService> delegate = _LocalizationServiceDelegate();

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static String of_(BuildContext context, String key) {
    return LocalizationService.of(context)?.translate(key) ?? key;
  }
}

class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService localization = LocalizationService(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizationServiceDelegate old) => false;
}

// Extension for easy access to translations
extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return LocalizationService.of(this)?.translate(key) ?? key;
  }
}

// Riverpod Notifier for locale management
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Load saved language code from SharedPreferences
    String savedLangCode = SharedPreferenceManager.sharedInstance.getLangCode();
    return Locale(savedLangCode);
  }

  void changeLanguage(String languageCode) {
    if (!['en', 'es'].contains(languageCode)) return;
    state = Locale(languageCode);
    // Save to SharedPreferences
    SharedPreferenceManager.sharedInstance.storeLangCode(languageCode);
  }
}

// Riverpod provider for locale
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});

