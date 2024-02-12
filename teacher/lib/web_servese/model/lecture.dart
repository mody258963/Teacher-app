class Lecture {
  int? id;
  String? name;
  String? description;
  int? courseId;

  Lecture({
    required this.id,
    required this.name,
    required this.description,
    required this.courseId,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      courseId: json['course_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'course_id': courseId,
    };
  }
}
