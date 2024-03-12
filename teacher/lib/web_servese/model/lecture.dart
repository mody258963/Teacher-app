class Lecture {
  Lec data;

  Lecture({
    required this.data,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      data: Lec.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Lec {
  int id;
  String title;
  String description;
  int teacherId;
  int categoryId;
  String book;
  String image;
  String createdAt;
  String updatedAt;

  Lec({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.categoryId,
    required this.book,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

   factory Lec.fromJson(Map<String, dynamic> json) {
    return Lec(
      id: json['id'] ?? 0, // Providing a default value if null
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      teacherId: json['teacher_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      book: json['book'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '2000-01-01T00:00:00.000000Z',
      updatedAt: json['updated_at'] ?? '2000-01-01T00:00:00.000000Z'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacher_id': teacherId,
      'category_id': categoryId,
      'book': book,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}