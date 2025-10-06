class CategoryDataModel {
  final int? id;
  final String title;
  final String icon;

  const CategoryDataModel({
    required this.title,
    required this.icon,
    this.id,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      id: json['category_id'] ?? json['id'], // handles both API formats
      title: json['category_name'] ?? json['title'] ?? '',
      icon: json['category_image_link'] ?? json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'category_name': title,
      'category_image_link': icon,
    };
  }

  CategoryDataModel copyWith({
    int? id,
    String? title,
    String? icon,
  }) {
    return CategoryDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() => 'CategoryDataModel(id: $id, title: $title, icon: $icon)';
}
