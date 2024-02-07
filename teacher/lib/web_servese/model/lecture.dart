class Lecture {
  int? id;
  String? title;
  String? description;
  int? teacherId;
  int? categoryId;

  Lecture({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.categoryId,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      teacherId: json['teacher_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacher_id': teacherId,
      'category_id': categoryId,
    };
  }
}
