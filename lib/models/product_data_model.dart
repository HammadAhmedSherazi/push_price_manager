import 'package:push_price_manager/export_all.dart';

class ProductDataModel {
  final String title;
  final String description;
  final String image;
  final num? price;
  final num? discounted_price;
  final int? id;
  final int ? chainId;
  final DateTime ? createdAt;
  final CategoryDataModel? category;
  final StoreDataModel ? store;
  final List<StoreDataModel>? stores;

  const ProductDataModel({
    required this.title,
    required this.description,
    required this.image,
    this.price,
    this.discounted_price,
    this.id,
    this.category,
    this.chainId,
    this.createdAt,
    this.store,
    this.stores
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['product_id'] ?? -1,
      title: json['product_name'] ?? '',
      description: json['product_description'] ?? '',
      image: json['product_image'] ?? '',
      price: (json['base_price'] as num?) ?? 0,
      discounted_price: (json['discounted_price'] as num?) ?? 0,

      category: json['category'] != null ? CategoryDataModel.fromJson(json['category']) : null,
      chainId: json['chain_id'] ?? -1,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      store: json['store']!= null ?StoreDataModel.fromJson(json['store']) :StoreDataModel(),
      stores: json['stores'] != null ? (json['stores'] as List).map((e)=> StoreDataModel.fromJson(e)).toList() : []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': title,
      'product_description': description,
      'product_image': image,
      'base_price': price,
      'discounted_price': discounted_price,
    };
  }

  ProductDataModel copyWith({
    String? title,
    String? description,
    String? image,
    num? price,
    num? discounted_price
    
    
  }) {
    return ProductDataModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      discounted_price: discounted_price ?? this.discounted_price,
    );
  }
}


class ProductSelectionDataModel extends ProductDataModel {
  final bool isSelect;

  const ProductSelectionDataModel({
    required super.title,
    required super.description,
    required super.image,
    super.price,
    required this.isSelect,
  });

  factory ProductSelectionDataModel.fromJson(Map<String, dynamic> json, {bool isSelect = false}) {
    final base = ProductDataModel.fromJson(json);
    return ProductSelectionDataModel(
      title: base.title,
      description: base.description,
      image: base.image,
      price: base.price,
      isSelect: isSelect,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final base = super.toJson();
    base['isSelect'] = isSelect;
    return base;
  }

  @override
  ProductSelectionDataModel copyWith({
    String? title,
    String? description,
    String? image,
    num? price,
    bool? isSelect,
    num? discounted_price
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

  const ProductPurchasingDataModel({
    required super.title,
    required super.description,
    required super.image,
    super.price,
    required this.quantity,
    required this.discountAmount,
  });

  factory ProductPurchasingDataModel.fromJson(Map<String, dynamic> json,
      {int quantity = 1, num discountAmount = 0}) {
    final base = ProductDataModel.fromJson(json);
    return ProductPurchasingDataModel(
      title: base.title,
      description: base.description,
      image: base.image,
      price: base.price,
      quantity: quantity,
      discountAmount: discountAmount,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final base = super.toJson();
    base.addAll({
      'quantity': quantity,
      'discountAmount': discountAmount,
    });
    return base;
  }

  @override
  ProductPurchasingDataModel copyWith({
    String? title,
    String? description,
    String? image,
    num? price,
    int? quantity,
    num? discountAmount,
    num? discounted_price
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

