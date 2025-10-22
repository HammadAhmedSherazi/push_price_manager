class CategoryDataModel {
  final int? id;
  final String title;
  final String icon;
  final int? chainId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isSelect;
  const CategoryDataModel({
    required this.title,
    required this.icon,
    this.id,
    this.chainId,
    this.createdAt,
    this.updatedAt,
    this.isSelect = false
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      id: json['category_id'] ?? json['id'],
      title: json['category_name'] ?? json['title'] ?? '',
      icon: json['category_image_link'] ?? json['icon'] ?? '',
      chainId: json['chain_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      isSelect: false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'category_name': title,
      'category_image_link': icon,
      if (chainId != null) 'chain_id': chainId,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  CategoryDataModel copyWith({
    int? id,
    String? title,
    String? icon,
    int? chainId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSelect
  }) {
    return CategoryDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      chainId: chainId ?? this.chainId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelect: isSelect ?? this.isSelect
    );
  }

  @override
  String toString() => 'CategoryDataModel(id: $id, title: $title, icon: $icon, chainId: $chainId, createdAt: $createdAt, updatedAt: $updatedAt)';
}
