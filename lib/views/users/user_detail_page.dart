import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../viewmodels/user_detail_viewmodel.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/note_list.dart';
import '../../widgets/user_header.dart';
import '../../models/note.dart';
import '../../viewmodels/notes_viewmodel.dart';
import '../notes/note_form_page.dart';
import '../../constants.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  const UserDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> with SingleTickerProviderStateMixin {
  UserDetailViewModel? _viewModel;
  List<Note>? _notes;

  @override
  void initState() {
    super.initState();
    _viewModel = UserDetailViewModel(widget.user, this);
  }

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);
    _notes = notesViewModel.notes;

    if (_viewModel == null || _notes == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
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
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return ChangeNotifierProvider<UserDetailViewModel>.value(
      value: _viewModel!,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name, style: TextStyle(color: Colors.white)),
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
        body: Consumer<UserDetailViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserHeader(user: widget.user),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Notes:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TabBar(
                  controller: viewModel.tabController,
                  labelColor: primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: primaryColor,
                  indicatorWeight: 3.0,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Good'),
                    Tab(text: 'Nul'),
                    Tab(text: 'Bad'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: viewModel.tabController,
                    children: [
                      NoteList(notes: viewModel.getNotesForUser(_notes!), appreciationFilter: 'all'),
                      NoteList(notes: viewModel.getNotesForUser(_notes!, appreciation: 'good'), appreciationFilter: 'good'),
                      NoteList(notes: viewModel.getNotesForUser(_notes!, appreciation: 'nul'), appreciationFilter: 'nul'),
                      NoteList(notes: viewModel.getNotesForUser(_notes!, appreciation: 'bad'), appreciationFilter: 'bad'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoteFormPage(user: widget.user)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
