import 'package:push_price_manager/models/product_data_model.dart';
import 'package:push_price_manager/models/user_data_model.dart';

class ListingModel {
  final double averagePrice;
  final String createdAt;
  final String status;
  final double currentDiscount;
  final String updatedAt;
  final int productId;
  final String initiatorType;
  final double dailyIncreasingDiscountPercent;
  final String listingType;
  final String discountStartDate;
  final int managerId;
  final int quantity;
  final String discountEndDate;
  final int employeeId;
  final String bestByDate;
  final String goLiveDate;
  final int listingId;
  final double weightedItemsPrices;
  final bool saveDiscountForFuture;
  final int storeId;
  final bool autoApplyForNextBatch;
  final Manager manager;
  final Store store;
  final ProductDataModel? product;
  final UserDataModel? employee;

  const ListingModel({
    this.averagePrice = 0.0,
    this.createdAt = '',
    this.status = '',
    this.currentDiscount = 0.0,
    this.updatedAt = '',
    this.productId = 0,
    this.initiatorType = '',
    this.dailyIncreasingDiscountPercent = 0.0,
    this.listingType = '',
    this.discountStartDate = '',
    this.managerId = 0,
    this.quantity = 0,
    this.discountEndDate = '',
    this.employeeId = 0,
    this.bestByDate = '',
    this.goLiveDate = '',
    this.listingId = 0,
    this.weightedItemsPrices = 0.0,
    this.saveDiscountForFuture = false,
    this.storeId = 0,
    this.autoApplyForNextBatch = false,
    this.manager = const Manager(),
    this.store = const Store(),
    this.product ,
    this.employee ,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
        averagePrice: (json['average_price'] ?? 0).toDouble(),
        createdAt: json['created_at'] ?? '',
        status: json['status'] ?? '',
        currentDiscount: (json['current_discount'] ?? 0).toDouble(),
        updatedAt: json['updated_at'] ?? '',
        productId: json['product_id'] ?? 0,
        initiatorType: json['initiator_type'] ?? '',
        dailyIncreasingDiscountPercent:
            (json['daily_increasing_discount_percent'] ?? 0).toDouble(),
        listingType: json['listing_type'] ?? '',
        discountStartDate: json['discount_start_date'] ?? '',
        managerId: json['manager_id'] ?? 0,
        quantity: json['quantity'] ?? 0,
        discountEndDate: json['discount_end_date'] ?? '',
        employeeId: json['employee_id'] ?? 0,
        bestByDate: json['best_by_date'] ?? '',
        goLiveDate: json['go_live_date'] ?? '',
        listingId: json['listing_id'] ?? 0,
        weightedItemsPrices: (json['weighted_items_prices'] ?? 0).toDouble(),
        saveDiscountForFuture: json['save_discount_for_future'] ?? false,
        storeId: json['store_id'] ?? 0,
        autoApplyForNextBatch: json['auto_apply_for_next_batch'] ?? false,
        manager: json['manager'] != null
            ? Manager.fromJson(json['manager'])
            : const Manager(),
        store:
            json['store'] != null ? Store.fromJson(json['store']) : const Store(),
        product: json['product'] != null
            ? ProductDataModel.fromJson(json['product'])
            : null,
        employee: json['employee'] != null
            ? UserDataModel.fromJson(json['employee'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'average_price': averagePrice,
        'created_at': createdAt,
        'status': status,
        'current_discount': currentDiscount,
        'updated_at': updatedAt,
        'product_id': productId,
        'initiator_type': initiatorType,
        'daily_increasing_discount_percent': dailyIncreasingDiscountPercent,
        'listing_type': listingType,
        'discount_start_date': discountStartDate,
        'manager_id': managerId,
        'quantity': quantity,
        'discount_end_date': discountEndDate,
        'employee_id': employeeId,
        'best_by_date': bestByDate,
        'go_live_date': goLiveDate,
        'listing_id': listingId,
        'weighted_items_prices': weightedItemsPrices,
        'save_discount_for_future': saveDiscountForFuture,
        'store_id': storeId,
        'auto_apply_for_next_batch': autoApplyForNextBatch,
        'manager': manager.toJson(),
        'store': store.toJson(),
        // 'product': product.toJson(),
        // 'employee': employee.toJson(),
      };
}

class Store {
  final String storeOperationalHours;
  final String updatedAt;
  final int storeId;
  final int chainId;
  final String storeName;
  final String storeLocation;
  final String createdAt;

  const Store({
    this.storeOperationalHours = '',
    this.updatedAt = '',
    this.storeId = 0,
    this.chainId = 0,
    this.storeName = '',
    this.storeLocation = '',
    this.createdAt = '',
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeOperationalHours: json['store_operational_hours'] ?? '',
        updatedAt: json['updated_at'] ?? '',
        storeId: json['store_id'] ?? 0,
        chainId: json['chain_id'] ?? 0,
        storeName: json['store_name'] ?? '',
        storeLocation: json['store_location'] ?? '',
        createdAt: json['created_at'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'store_operational_hours': storeOperationalHours,
        'updated_at': updatedAt,
        'store_id': storeId,
        'chain_id': chainId,
        'store_name': storeName,
        'store_location': storeLocation,
        'created_at': createdAt,
      };
}

class Manager {
  const Manager();

  factory Manager.fromJson(Map<String, dynamic> json) => const Manager();

  Map<String, dynamic> toJson() => {};
}
