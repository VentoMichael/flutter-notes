import 'package:flutter/material.dart';
import 'package:flutter_project/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import 'models/settings.dart';  // Make sure this path is correct
import 'models/user.dart';
import 'pages/home/home_page.dart';
import 'pages/settings/settings_page.dart';
import 'pages/users/user_detail_page.dart';
import 'viewmodels/notes_viewmodel.dart';
import 'viewmodels/users_viewmodel.dart';
import 'viewmodels/settings_viewmodel.dart'; // Correct import for the Settings ViewModel

void main() {
  final setting = Setting(isDarkModeEnabled: false);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersViewModel()),
        ChangeNotifierProvider(create: (_) => NotesViewModel()),
        ChangeNotifierProvider(create: (_) => SettingViewModel(setting)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingViewModel>(
      builder: (context, settingViewModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: settingViewModel.setting.isDarkModeEnabled
                ? Brightness.dark
                : Brightness.light,
          ),
          initialRoute: '/home',
          routes: {
            '/home': (context) => HomePage(),
            '/userDetail': (context) {
              final User user = ModalRoute.of(context)!.settings.arguments as User;
              return UserDetailPage(user: user);
            },
            '/settings': (context) => SettingsPage(),
          },
        );
      },
    );
  }
}
