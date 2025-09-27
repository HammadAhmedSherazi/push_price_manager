class ProductDataModel {
  late final String title;
  late final String description;
  late final String image;
  late final num ? price;
  
  ProductDataModel({required this.title, required this.description, required this.image, this.price});
}

// New model for real product data from JSON
class RealProductDataModel {
  final String item;
  final double regularPrice;
  final double bestBuyPrice;
  final String bestByDate;
  final String? image;
  final String? category;
  final String? description;

  RealProductDataModel({
    required this.item,
    required this.regularPrice,
    required this.bestBuyPrice,
    required this.bestByDate,
    this.image,
    this.category,
    this.description,
  });

  factory RealProductDataModel.fromJson(Map<String, dynamic> json) {
    return RealProductDataModel(
      item: json['item'] ?? '',
      regularPrice: (json['regular_price'] ?? 0.0).toDouble(),
      bestBuyPrice: (json['best_buy_price'] ?? 0.0).toDouble(),
      bestByDate: json['best_by_date'] ?? '',
      image: json['image'],
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'regular_price': regularPrice,
      'best_buy_price': bestBuyPrice,
      'best_by_date': bestByDate,
      'image': image,
      'category': category,
      'description': description,
    };
  }

  // Convert to ProductDataModel for compatibility
  ProductDataModel toProductDataModel() {
    return ProductDataModel(
      title: item,
      description: description ?? 'Fresh grocery item',
      image: image ?? 'assets/images/placeholder_image.webp',
      price: regularPrice,
    );
  }

  // Convert to ProductSelectionDataModel for compatibility
  ProductSelectionDataModel toProductSelectionDataModel({bool isSelect = false}) {
    return ProductSelectionDataModel(
      title: item,
      description: category ?? 'Grocery',
      image: image ?? 'assets/images/placeholder_image.webp',
      price: regularPrice,
      isSelect: isSelect,
    );
  }
}

class ProductSelectionDataModel extends ProductDataModel {
  final bool isSelect;

  ProductSelectionDataModel({
    required super.title,
    required super.description,
    required super.image,
    super.price,
    required this.isSelect,
  });

  ProductSelectionDataModel copyWith({
    String? title,
    String? description,
    String? image,
    num? price,
    bool? isSelect,
  }) {
    return ProductSelectionDataModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
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
