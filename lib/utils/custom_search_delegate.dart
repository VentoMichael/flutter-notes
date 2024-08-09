import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/note.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<User> users;
  final List<Note> notes;

  CustomSearchDelegate(this.users, this.notes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final userResults = users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.role.toLowerCase().contains(query.toLowerCase());
    }).toList();

    final noteResults = notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.separated(
      separatorBuilder: (context, index) {
        // Adding space between different sections
        if (index == 0 && userResults.isNotEmpty) return SizedBox(height: 16.0);
        if (index == userResults.length && noteResults.isNotEmpty) return SizedBox(height: 16.0);
        return Divider();
      },
      itemCount: userResults.length + noteResults.length + 2, // Extra items for headers and spacers
      itemBuilder: (context, index) {
        if (index == 0 && userResults.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Users',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        if (index == userResults.length + 1 && noteResults.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        final itemIndex = index < userResults.length ? index : index - 1;
        if (index < userResults.length) {
          final user = userResults[itemIndex];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.role),
            onTap: () {
              Navigator.pushNamed(context, '/userDetail', arguments: user);
            },
          );
        } else {
          final note = noteResults[itemIndex];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            onTap: () {
              Navigator.pushNamed(context, '/noteDetail', arguments: note);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final userSuggestions = users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.role.toLowerCase().contains(query.toLowerCase());
    }).toList();

    final noteSuggestions = notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView(
      children: [
        if (userSuggestions.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0), // Only top margin
            child: Text(
              'Users',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...userSuggestions.map((user) {
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.role),
              onTap: () {
                query = user.name;
                Navigator.pushNamed(context, '/userDetail', arguments: user);
              },
            );
          }).toList(),
        ],
        if (noteSuggestions.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0), // Only top margin
            child: Text(
              'Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...noteSuggestions.map((note) {
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              onTap: () {
                query = note.title;
                Navigator.pushNamed(context, '/noteDetail', arguments: note);
              },
            );
          }).toList(),
        ],
      ],
    );
  }
}
