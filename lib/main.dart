import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'pages/users/user_detail_page.dart';
import 'viewmodels/users_viewmodel.dart';
import 'viewmodels/notes_viewmodel.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersViewModel()),
        ChangeNotifierProvider(create: (_) => NotesViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/userDetail': (context) {
          final User user = ModalRoute.of(context)!.settings.arguments as User;
          return UserDetailPage(user: user);
        },
      },
    );
  }
}
