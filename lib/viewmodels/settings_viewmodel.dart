// lib/viewmodels/setting_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/settings.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsViewModel extends ChangeNotifier {
  Setting _setting;

  SettingsViewModel(this._setting);

  Setting get setting => _setting;

  void toggleDarkMode(bool value) {
    _setting = Setting(isDarkModeEnabled: value);
    notifyListeners();
  }
}
