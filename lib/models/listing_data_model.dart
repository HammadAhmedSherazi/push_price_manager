import '../export_all.dart';


class ListingModel {
  final double averagePrice;
  final DateTime? createdAt;
  final String status;
  final double currentDiscount;
  final DateTime? updatedAt;
  final int productId;
  final String initiatorType;
  final double dailyIncreasingDiscountPercent;
  final double hourlyIncreasingDiscountPercent;
  final String listingType;
  final String discountStartDate;
  final int managerId;
  final int quantity;
  final String discountEndDate;
  final int employeeId;
  final DateTime? bestByDate;
  final DateTime? goLiveDate;
  final int listingId;
  final List<double>? weightedItemsPrices;
  final bool saveDiscountForFuture;
  final bool saveDiscountForListing;
  final int storeId;
  final bool autoApplyForNextBatch;
  final Manager manager;
  final StoreDataModel store;
  final ProductDataModel? product;
  final UserDataModel? employee;

  const ListingModel({
    this.averagePrice = 0.0,
    this.createdAt,
    this.status = '',
    this.currentDiscount = 0.0,
    this.updatedAt,
    this.productId = 0,
    this.initiatorType = '',
    this.dailyIncreasingDiscountPercent = 0.0,
    this.hourlyIncreasingDiscountPercent = 0.0,
    this.listingType = '',
    this.discountStartDate = '',
    this.managerId = 0,
    this.quantity = 0,
    this.discountEndDate = '',
    this.employeeId = 0,
    this.bestByDate,
    this.goLiveDate,
    this.listingId = 0,
    this.weightedItemsPrices ,
    this.saveDiscountForFuture = false,
    this.storeId = 0,
    this.autoApplyForNextBatch = false,
    this.manager = const Manager(),
    this.store = const StoreDataModel(),
    this.product,
    this.employee,
    this.saveDiscountForListing = false,
  });

  /// ✅ Factory for parsing JSON safely with type conversion and date parsing
  factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
        averagePrice: (json['average_price'] ?? 0).toDouble(),
        createdAt: json['created_at'] != null && json['created_at'] != ''
            ? DateTime.tryParse(json['created_at'])
            : null,
        status: json['status'] ?? '',
        currentDiscount: (json['current_discount'] ?? 0).toDouble(),
        updatedAt: json['updated_at'] != null && json['updated_at'] != ''
            ? DateTime.tryParse(json['updated_at'])
            : null,
        productId: json['product_id'] ?? 0,
        initiatorType: json['initiator_type'] ?? '',
        dailyIncreasingDiscountPercent:
            (json['daily_increasing_discount_percent'] ?? 0).toDouble(),
        hourlyIncreasingDiscountPercent:
            (json['hourly_increasing_discount'] ?? 0).toDouble(),
        listingType: json['listing_type'] ?? '',
        discountStartDate: json['discount_start_date'] ?? '',
        managerId: json['manager_id'] ?? 0,
        quantity: json['quantity'] ?? 0,
        discountEndDate: json['discount_end_date'] ?? '',
        employeeId: json['employee_id'] ?? 0,
        bestByDate: json['best_by_date'] != null && json['best_by_date'] != ''
            ? DateTime.tryParse(json['best_by_date'])
            : null,
        goLiveDate: json['go_live_date'] != null && json['go_live_date'] != ''
            ? DateTime.tryParse(json['go_live_date'])
            : null,
        listingId: json['listing_id'] ?? 0,
        weightedItemsPrices:  json['weighted_items_prices'] != null ?List.from(json['weighted_items_prices'].map((e) => e.toDouble())) : [],
        saveDiscountForFuture: json['save_discount_for_future'] ?? false,
        saveDiscountForListing: json['save_discount_for_listing'] ?? false,
        storeId: json['store_id'] ?? 0,
        autoApplyForNextBatch: json['auto_apply_for_next_batch'] ?? false,
        manager: json['manager'] != null
            ? Manager.fromJson(json['manager'])
            : const Manager(),
        store: json['store'] != null
            ? StoreDataModel.fromJson(json['store'])
            : const StoreDataModel(),
        product: json['product'] != null
            ? ProductDataModel.fromJson(json['product'])
            : null,
        employee: json['employee'] != null
            ? UserDataModel.fromJson(json['employee'])
            : null,
      );

  /// ✅ Convert to JSON safely
  Map<String, dynamic> toJson() => {
        'average_price': averagePrice,
        'created_at': createdAt?.toIso8601String(),
        'status': status,
        'current_discount': currentDiscount,
        'updated_at': updatedAt?.toIso8601String(),
        'product_id': productId,
        'initiator_type': initiatorType,
        'daily_increasing_discount_percent': dailyIncreasingDiscountPercent,
        'hourly_increasing_discount': hourlyIncreasingDiscountPercent,
        'listing_type': listingType,
        'discount_start_date': discountStartDate,
        'manager_id': managerId,
        'quantity': quantity,
        'discount_end_date': discountEndDate,
        'employee_id': employeeId,
        'best_by_date': bestByDate?.toIso8601String(),
        'go_live_date': goLiveDate?.toIso8601String(),
        'listing_id': listingId,
        'weighted_items_prices': weightedItemsPrices,
        'save_discount_for_future': saveDiscountForFuture,
        'save_discount_for_listing': saveDiscountForListing,
        'store_id': storeId,
        'auto_apply_for_next_batch': autoApplyForNextBatch,
        'manager': manager.toJson(),
        'store': store.toJson(),
      };

  /// ✅ `copyWith()` for immutability
  ListingModel copyWith({
    double? averagePrice,
    DateTime? createdAt,
    String? status,
    double? currentDiscount,
    DateTime? updatedAt,
    int? productId,
    String? initiatorType,
    double? dailyIncreasingDiscountPercent,
    double? hourlyIncreasingDiscountPercent,
    String? listingType,
    String? discountStartDate,
    int? managerId,
    int? quantity,
    String? discountEndDate,
    int? employeeId,
    DateTime? bestByDate,
    DateTime? goLiveDate,
    int? listingId,
    List<double>? weightedItemsPrices,
    bool? saveDiscountForFuture,
    bool? saveDiscountForListing,
    int? storeId,
    bool? autoApplyForNextBatch,
    Manager? manager,
    StoreDataModel? store,
    ProductDataModel? product,
    UserDataModel? employee,
  }) {
    return ListingModel(
      averagePrice: averagePrice ?? this.averagePrice,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      currentDiscount: currentDiscount ?? this.currentDiscount,
      updatedAt: updatedAt ?? this.updatedAt,
      productId: productId ?? this.productId,
      initiatorType: initiatorType ?? this.initiatorType,
      dailyIncreasingDiscountPercent:
          dailyIncreasingDiscountPercent ?? this.dailyIncreasingDiscountPercent,
      hourlyIncreasingDiscountPercent:
          hourlyIncreasingDiscountPercent ?? this.hourlyIncreasingDiscountPercent,
      listingType: listingType ?? this.listingType,
      discountStartDate: discountStartDate ?? this.discountStartDate,
      managerId: managerId ?? this.managerId,
      quantity: quantity ?? this.quantity,
      discountEndDate: discountEndDate ?? this.discountEndDate,
      employeeId: employeeId ?? this.employeeId,
      bestByDate: bestByDate ?? this.bestByDate,
      goLiveDate: goLiveDate ?? this.goLiveDate,
      listingId: listingId ?? this.listingId,
      weightedItemsPrices: weightedItemsPrices ?? this.weightedItemsPrices,
      saveDiscountForFuture: saveDiscountForFuture ?? this.saveDiscountForFuture,
      saveDiscountForListing: saveDiscountForListing ?? this.saveDiscountForListing,
      storeId: storeId ?? this.storeId,
      autoApplyForNextBatch: autoApplyForNextBatch ?? this.autoApplyForNextBatch,
      manager: manager ?? this.manager,
      store: store ?? this.store,
      product: product ?? this.product,
      employee: employee ?? this.employee,
    );
  }
}


class Manager {
  const Manager();

  factory Manager.fromJson(Map<String, dynamic> json) => const Manager();

  Map<String, dynamic> toJson() => {};
}
