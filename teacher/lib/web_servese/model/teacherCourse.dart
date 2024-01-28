class TecherCourse {
  final int id;
  final String title;
  final String description;

  TecherCourse({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TecherCourse.fromJson(Map<String, dynamic> json) {
    return TecherCourse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}