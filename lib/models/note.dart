class Note {
  String? id;
  String title;
  String content;
  DateTime dateTime;
  int colorValue;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    this.colorValue = 0xFFDFD0B8,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'colorValue': colorValue,
    };
  }

  factory Note.fromMap(Map<dynamic, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] ?? DateTime.now().millisecondsSinceEpoch),
      colorValue: map['colorValue'] ?? 0xFFDFD0B8,
    );
  }
}
