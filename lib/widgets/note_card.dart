// lib/widgets/note_card.dart

import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({required this.note, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _getAppreciationIcon(note.appreciation),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  _truncateText(note.content, 60),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _formatDate(note.date),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAppreciationIcon(String appreciation) {
    IconData iconData;
    Color color;

    switch (appreciation) {
      case 'good':
        iconData = Icons.thumb_up;
        color = Colors.green;
        break;
      case 'bad':
        iconData = Icons.thumb_down;
        color = Colors.red;
        break;
      case 'nul':
        iconData = Icons.cancel;
        color = Colors.grey;
        break;
      default:
        iconData = Icons.help;
        color = Colors.black;
        break;
    }

    return Icon(
      iconData,
      color: color,
      size: 24.0,
    );
  }

  String _truncateText(String text, int maxLength) {
    return text.length <= maxLength ? text : text.substring(0, maxLength) + '...';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
