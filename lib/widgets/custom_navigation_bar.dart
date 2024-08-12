import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../constants.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);
    final isDarkMode = settingsViewModel.setting.isDarkModeEnabled;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, -2),
              )
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: 30),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30),
                label: 'Paramètres',
              ),
            ],
            currentIndex: _getSelectedIndex(context),
            onTap: (index) => _onItemTapped(context, index),
          ),
        ),
        Positioned(
          top: -45,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              onPressed: () {

                Navigator.pushReplacementNamed(context, '/addNote');
              },
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_rounded,
                    size: 40,
                    color: Colors.white.withOpacity(0.7),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    switch (currentRoute) {
      case '/home':
        return 0;
      case '/settings':
        return 1;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }
}
