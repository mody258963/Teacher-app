class Category {
  int? id;
  String? title;

  Category({
    this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'] as int, title: json['title'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    return data;
  }
}
