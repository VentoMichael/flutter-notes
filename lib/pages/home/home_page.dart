import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';
import '../../viewmodels/users_viewmodel.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/user_card.dart';
import '../../utils/custom_search_delegate.dart';
import '../../models/user.dart';
import '../../models/note.dart';
import '../../constants.dart'; // Import the constants file

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usersViewModel = Provider.of<UsersViewModel>(context);
    final notesViewModel = Provider.of<NotesViewModel>(context);

    // Use empty lists if users or notes are null
    final users = usersViewModel.users ?? [];
    final notes = notesViewModel.notes ?? [];

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
    final hour = now.hour + 2;

    String greeting;

    if (hour < 12) {
      greeting = 'Bonjour, Michael !';
    } else if (hour < 18) {
      greeting = 'Bonjour, Michael!';
    } else {
      greeting = 'Bonsoir, Michael !';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor, // Use the color constant
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
                            color: textColor, // Use the color constant
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
