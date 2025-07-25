class ProductDataModel {
  late final String title;
  late final String description;
  late final String image;
  late final num ? price;
  
  ProductDataModel({required this.title, required this.description, required this.image, this.price});
}

class ProductSelectionDataModel extends ProductDataModel {
  final bool isSelect;

  ProductSelectionDataModel({
    required super.title,
    required super.description,
    required super.image,
    required this.isSelect,
    
  });

  ProductSelectionDataModel copyWith({
    String? title,
    String? description,
    String? image,
    bool? isSelect,
  }) {
    return ProductSelectionDataModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      isSelect: isSelect ?? this.isSelect,
    );
  }
}

class ProductPurchasingDataModel extends ProductDataModel {
  final int quantity;
  final num discountAmount;

  ProductPurchasingDataModel({
    required super.title,
    required super.description,
    required super.image,
    super.price,
    required this.quantity,
    required this.discountAmount,
  });

  ProductPurchasingDataModel copyWith({
    String? title,
    String? description,
    String? image,
    num? price,
    int? quantity,
    num? discountAmount,
  }) {
    return ProductPurchasingDataModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discountAmount: discountAmount ?? this.discountAmount,
    );
  }
}
