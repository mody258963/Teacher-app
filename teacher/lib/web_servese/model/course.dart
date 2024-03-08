// class Course {
//   int? id;
//   String? title;
//   String? description;
//   int? teacherId;
//   int? categoryId;
//   String? book;
//   String? image;
//   String? created_at;
//   String? updated_at;

//   Course({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.teacherId,
//     required this.categoryId,
//     required this.book,
//     required this.image,
//     required this.created_at,
//     required this.updated_at,
//   });

//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       description: json['description'] as String,
//       teacherId: json['teacher_id'] as int,
//       categoryId: json['category_id'] as int,
//       book: json['book'] as String,
//       image: json['image'] as String,
//       created_at: json['created_at'] as String,
//       updated_at: json['updated_at'] as String,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data["id"] = id;
//     data["title"] = title;
//     data["description"] = description;
//     data["teacher_id"] = teacherId;
//     data["category_id"] = categoryId;
//     data["book"] = book;
//     data["image"] = image;
//     data["created_at"] = created_at;
//     data["updated_at"] = updated_at;
//     return data;
//   }
// }

class Course {
  Data data;

  Course({
    required this.data,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Data {
  int id;
  String title;
  String description;
  int teacherId;
  int categoryId;
  String book;
  String image;
  String createdAt;
  String updatedAt;

  Data({
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

   factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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