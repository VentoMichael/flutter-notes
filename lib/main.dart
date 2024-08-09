import 'package:flutter/material.dart';
import 'package:flutter_project/pages/users/user_detail_page.dart';
import 'package:provider/provider.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'pages/settings/settings_page.dart';
import 'pages/home/home_page.dart';
import 'viewmodels/users_viewmodel.dart';
import 'viewmodels/notes_viewmodel.dart';
import 'models/settings.dart';
import 'models/user.dart';

void main() {
  final setting = Setting(isDarkModeEnabled: false);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersViewModel()),
        ChangeNotifierProvider(create: (_) => NotesViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel(setting)),
      ],
      child: MyApp(),
    ),
  );
}

// Define your light theme
final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // AppBar title
  ),
  // Define other colors and properties as needed
);

// Define your dark theme
final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // AppBar title
  ),
  // Define other colors and properties as needed
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settingsViewModel.setting.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
      initialRoute: '/home',
      routes: {
        '/userDetail': (context) {
          final User user = ModalRoute.of(context)!.settings.arguments as User;
          return UserDetailPage(user: user);
        },
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
