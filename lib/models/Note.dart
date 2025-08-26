class Note {
  final int id;
  final String title;
  final String description;
  final int userId;
  final String date;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      date: json['date'],
    );
  }
}
