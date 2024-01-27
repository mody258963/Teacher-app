class Course {
  int id;
  String title;
  String description;
  int teacherId;
  int categoryId;
  CoursePivot pivot;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.categoryId,
    required this.pivot,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      teacherId: json['teacher_id'] as int,
      categoryId: json['category_id'] as int,
      pivot: CoursePivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["teacher_id"] = teacherId;
    data["category_id"] = categoryId;
    return data;
  }
}

class CoursePivot {
  int userId;
  int courseId;

  CoursePivot({
    required this.userId,
    required this.courseId,
  });

  factory CoursePivot.fromJson(Map<String, dynamic> json) {
    return CoursePivot(
      userId: json['user_id'] as int,
      courseId: json['course_id'] as int,
    );
  }
}
