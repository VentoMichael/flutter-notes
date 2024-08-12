import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';
import '../../viewmodels/users_viewmodel.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/user_card.dart';
import '../../utils/custom_search_delegate.dart';
import '../../models/user.dart';
import '../../models/note.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final usersViewModel = Provider.of<UsersViewModel>(context, listen: false);
    usersViewModel.fetchUsers(); // Fetch all users if needed

    // Fetch user by ID
    // The ID should ideally be passed or determined based on context
    Future.delayed(Duration.zero, () async {
      await usersViewModel.fetchUserById(1); // Fetch user with ID 1
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersViewModel = Provider.of<UsersViewModel>(context);
    final notesViewModel = Provider.of<NotesViewModel>(context);
    final users = usersViewModel.users ?? [];
    final notes = notesViewModel.notes ?? [];
    final currentUser = usersViewModel.currentUser;

    final Map<String, List<User>> groupedByPosition = {};

    for (var user in users) {
      final mainPosition = user.mainPosition.isNotEmpty ? user.mainPosition : 'Unknown';
      if (groupedByPosition.containsKey(mainPosition)) {
        groupedByPosition[mainPosition]!.add(user);
      } else {
        groupedByPosition[mainPosition] = [user];
      }
    }

    final now = DateTime.now();
    final hour = now.hour;

    String greeting;

    if (hour < 12) {
      greeting = 'Bonjour, ${currentUser?.name ?? "Michael"} !';
    } else if (hour < 18) {
      greeting = 'Bonjour, ${currentUser?.name ?? "Michael"} !';
    } else {
      greeting = 'Bonsoir, ${currentUser?.name ?? "Michael"} !';
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          width: 200,
          fit: BoxFit.cover,
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            iconSize: 35,
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(users, notes),
              );
            },
          ),
        ],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: usersViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comment allez-vous aujourd\'hui ?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: groupedByPosition.keys.map((mainPosition) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainPosition,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: groupedByPosition[mainPosition]!.map((user) {
                            return UserCard(user: user);
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
