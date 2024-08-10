import 'package:flutter/material.dart';
import '../models/note.dart';
import '../constants.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final String appreciationFilter;

  const NoteList({
    required this.notes,
    required this.appreciationFilter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      String message;
      IconData appreciationIcon;

      switch (appreciationFilter) {
        case 'good':
          message = 'No good notes';
          appreciationIcon = Icons.thumb_up;
          break;
        case 'nul':
          message = 'No neutral notes';
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
          color: cardColor,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              note.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: textColor,
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

  String _truncateText(String text, int length) {
    return text.length > length ? text.substring(0, length) + '...' : text;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getIconColor(String appreciation) {
    switch (appreciation) {
      case 'good':
        return iconGoodColor;
      case 'nul':
        return iconNulColor;
      case 'bad':
        return iconBadColor;
      default:
        return Colors.grey;
    }
  }

  void _showFullTextDialog(BuildContext context, String title, String fullText, DateTime date, String appreciation) {
    IconData appreciationIcon = _getIconForAppreciation(appreciation);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          contentPadding: EdgeInsets.all(24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
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
          content: Container(
            child: Column(
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
