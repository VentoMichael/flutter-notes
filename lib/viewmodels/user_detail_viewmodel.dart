import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/note.dart';

class UserDetailViewModel extends ChangeNotifier {
  final User user;
  late TabController tabController;

  UserDetailViewModel(this.user, TickerProvider vsync) {
    tabController = TabController(length: 4, vsync: vsync);
  }

  List<Note> getNotesForUser(List<Note> allNotes, {String? appreciation}) {
    return allNotes.where((note) {
      bool matchesUser = note.userId == user.userId;
      bool matchesAppreciation = appreciation == null || note.appreciation == appreciation;
      return matchesUser && matchesAppreciation;
    }).toList();
  }
}
