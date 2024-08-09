import 'package:flutter/material.dart';
import 'package:flutter_project/constants.dart'; // Import your color constants
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../widgets/custom_navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);

    final isDarkMode = settingsViewModel.setting.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(
            color: Colors.white, // Set color for the title text
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryColor, // Set color for AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // Set color for AppBar icons
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
                color: isDarkMode ? Colors.white : Colors.black, // Set color based on theme
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black, // Set color based on theme
                ),
              ),
              value: settingsViewModel.setting.isDarkModeEnabled,
              onChanged: (value) {
                settingsViewModel.toggleDarkMode(value);
              },
              activeColor: primaryColor, // Set the color of the switch when it is active
              inactiveTrackColor: isDarkMode ? Colors.grey : Colors.black12, // Set the color of the track when inactive
              inactiveThumbColor: isDarkMode ? Colors.white : Colors.black, // Set the color of the thumb when inactive
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
