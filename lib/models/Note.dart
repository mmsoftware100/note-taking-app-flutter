class Note {
  final int id;
  final String title;
  final String description;
  final String date;
  final String createdAt;
  final String updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
