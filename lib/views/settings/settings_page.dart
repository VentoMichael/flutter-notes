import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../constants.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    final isDarkMode = settingsViewModel.setting.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/images/logo-white.png',
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              value: settingsViewModel.setting.isDarkModeEnabled,
              onChanged: (value) {
                settingsViewModel.toggleDarkMode(value);
              },
              activeColor: primaryColor,
              inactiveTrackColor: isDarkMode ? Colors.grey : Colors.black12,
              inactiveThumbColor: isDarkMode ? Colors.white : Colors.black,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                authViewModel.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Logout', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
