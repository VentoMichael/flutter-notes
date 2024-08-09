import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final String appreciationFilter; // New parameter for the filter

  const NoteList({
    required this.notes,
    required this.appreciationFilter, // Include filter in constructor
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      // Determine message based on the filter
      String message;
      IconData appreciationIcon;

      switch (appreciationFilter) {
        case 'good':
          message = 'No good notes';
          appreciationIcon = Icons.thumb_up;
          break;
        case 'nul':
          message = 'No neutral notes'; // Neutral message
          appreciationIcon = Icons.sentiment_neutral;
          break;
        case 'bad':
          message = 'No bad notes';
          appreciationIcon = Icons.sentiment_dissatisfied;
          break;
        default:
          message = 'No notes available';
          appreciationIcon = Icons.help;
          break;
      }

      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              appreciationIcon,
              color: _getIconColor(appreciationFilter),
              size: 30.0,
            ),
            SizedBox(width: 8.0),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        IconData appreciationIcon = _getIconForAppreciation(note.appreciation);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4.0,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              note.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _truncateText(note.content, 60),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.0),
                Text(
                  _formatDate(note.date),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: Icon(appreciationIcon, color: _getIconColor(note.appreciation)),
            onTap: () => _showFullTextDialog(context, note.title, note.content, note.date, note.appreciation),
          ),
        );
      },
    );
  }

  // Helper function to get icon based on appreciation type
  IconData _getIconForAppreciation(String appreciation) {
    switch (appreciation) {
      case 'good':
        return Icons.thumb_up;
      case 'nul':
        return Icons.sentiment_neutral;
      case 'bad':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.help;
    }
  }

  // Helper function to truncate text to a specified length
  String _truncateText(String text, int length) {
    return text.length > length ? text.substring(0, length) + '...' : text;
  }

  // Helper function to format date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Helper function to return color based on appreciation type
  Color _getIconColor(String appreciation) {
    switch (appreciation) {
      case 'good':
        return Colors.green;
      case 'nul':
        return Colors.orange;
      case 'bad':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Function to show a dialog with the full text
  void _showFullTextDialog(BuildContext context, String title, String fullText, DateTime date, String appreciation) {
    IconData appreciationIcon = _getIconForAppreciation(appreciation);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(24.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Icon(appreciationIcon, color: _getIconColor(appreciation)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullText,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(date),
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
