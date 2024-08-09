class Note {
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final String appreciation;

  Note({
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    this.appreciation = 'nul',
  });
}
