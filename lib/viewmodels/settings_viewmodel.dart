// lib/viewmodels/setting_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/settings.dart';

class SettingViewModel extends ChangeNotifier {
  Setting _setting;

  SettingViewModel(this._setting);

  Setting get setting => _setting;

  void toggleDarkMode(bool value) {
    _setting = Setting(isDarkModeEnabled: value);
    notifyListeners();
  }
}
