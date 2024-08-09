import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../models/note.dart';
import '../../viewmodels/notes_viewmodel.dart';
import '../../models/user.dart';
import '../../constants.dart';
import '../../widgets/custom_navigation_bar.dart'; // Import the constants file

class NoteFormPage extends StatefulWidget {
  final User user;

  const NoteFormPage({required this.user, Key? key}) : super(key: key);

  @override
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedAppreciation = 'good';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      // Handle the case where speech recognition is not available
    }
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _isListening = true;
          _lastWords = result.recognizedWords;
          _contentController.text = _lastWords;
        });
      },
    );
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note for ${widget.user.name}'),
        backgroundColor: primaryColor, // Use the color constant
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
              controller: _titleController,
              label: 'Title',
              hintText: 'Enter note title',
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                _buildTextField(
                  controller: _contentController,
                  label: 'Content',
                  hintText: 'Enter note content',
                  maxLines: 5,
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: IconButton(
                    icon: Icon(
                      _isListening ? Icons.stop : Icons.mic,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      if (_isListening) {
                        _stopListening();
                      } else {
                        _startListening();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDropdown(
              value: _selectedAppreciation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAppreciation = newValue!;
                });
              },
              items: ['good', 'nul', 'bad'],
              hintText: 'Select Appreciation',
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Use the color constant
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text(
                'Save Note',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Use the color constant
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
    required List<String> items,
    required String hintText,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value[0].toUpperCase() + value.substring(1)),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _addNote() {
    final title = _titleController.text;
    final content = _contentController.text;
    final appreciation = _selectedAppreciation;

    if (title.isEmpty || content.isEmpty) {
      // Handle empty fields
      return;
    }

    final note = Note(
      title: title,
      content: content,
      appreciation: appreciation,
      date: DateTime.now(),
      userId: widget.user.userId, // Ensure this property exists
    );

    final notesViewModel = Provider.of<NotesViewModel>(context, listen: false);
    notesViewModel.addNote(note);

    Navigator.pop(context);
  }
}
