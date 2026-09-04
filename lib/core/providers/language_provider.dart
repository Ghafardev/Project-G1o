import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { indonesian, english }

class LanguageProvider with ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.indonesian;
  
  AppLanguage get currentLanguage => _currentLanguage;
  
  bool get isIndonesian => _currentLanguage == AppLanguage.indonesian;
  bool get isEnglish => _currentLanguage == AppLanguage.english;

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'id';
    _currentLanguage = languageCode == 'en' ? AppLanguage.english : AppLanguage.indonesian;
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage language) async {
    _currentLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', language == AppLanguage.english ? 'en' : 'id');
    notifyListeners();
  }

  String getLanguageCode() {
    return _currentLanguage == AppLanguage.english ? 'en' : 'id';
  }

  String getLanguageName() {
    return _currentLanguage == AppLanguage.english ? 'English' : 'Bahasa Indonesia';
  }
}
