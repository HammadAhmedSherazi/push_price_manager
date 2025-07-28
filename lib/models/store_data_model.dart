class StoreDataModel {
  final String title;
  final String address;
  final double rating;
  final String icon;

  StoreDataModel({
    required this.title,
    required this.address,
    required this.rating,
    required this.icon,
  });
}

class StoreSelectDataModel extends StoreDataModel {
  final bool isSelected;

  StoreSelectDataModel({
    required super.title,
    required super.address,
    required super.rating,
    required super.icon,
    required this.isSelected,
  });

  StoreSelectDataModel copyWith({
    String? title,
    String? address,
    double? rating,
    String? icon,
    bool? isSelected,
  }) {
    return StoreSelectDataModel(
      title: title ?? this.title,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
