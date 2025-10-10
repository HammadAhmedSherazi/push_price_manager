class StoreDataModel {
  final int storeId;
  final String storeName;
  final String storeLocation;
  final String storeOperationalHours;
  final DateTime? assignedAt;
  final int chainId;

  const StoreDataModel({
    this.storeId = 0,
    this.storeName = '',
    this.storeLocation = '',
    this.storeOperationalHours = '',
    this.assignedAt,
    this.chainId = 0,
  });

  factory StoreDataModel.fromJson(Map<String, dynamic> json) {
    return StoreDataModel(
      storeId: json['store_id'] ?? 0,
      storeName: json['store_name'] ?? '',
      storeLocation: json['store_location'] ?? '',
      storeOperationalHours: json['store_operational_hours'] ?? '',
      assignedAt: json['assigned_at'] != null
          ? DateTime.tryParse(json['assigned_at'])
          : null,
      chainId: json['chain_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'store_id': storeId,
        'store_name': storeName,
        'store_location': storeLocation,
        'store_operational_hours': storeOperationalHours,
        'assigned_at': assignedAt?.toIso8601String(),
        'chain_id': chainId,
      };
}

class StoreSelectDataModel extends StoreDataModel {
  final bool isSelected;

  const StoreSelectDataModel({
    super.storeId = 0,
    super.storeName = '',
    super.storeLocation = '',
    super.storeOperationalHours = '',
    super.assignedAt,
    super.chainId = 0,
    this.isSelected = false,
  });
  factory StoreSelectDataModel.fromJson(Map<String, dynamic> json) {
    return StoreSelectDataModel(
      storeId: json['store_id'] ?? 0,
      storeName: json['store_name'] ?? '',
      storeLocation: json['store_location'] ?? '',
      storeOperationalHours: json['store_operational_hours'] ?? '',
      assignedAt: json['assigned_at'] != null
          ? DateTime.tryParse(json['assigned_at'])
          : null,
      chainId: json['chain_id'] ?? 0,
      isSelected: false
    );
  }
  StoreSelectDataModel copyWith({
    int? storeId,
    String? storeName,
    String? storeLocation,
    String? storeOperationalHours,
    DateTime? assignedAt,
    int? chainId,
    bool? isSelected,
  }) {
    return StoreSelectDataModel(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
      storeOperationalHours:
          storeOperationalHours ?? this.storeOperationalHours,
      assignedAt: assignedAt ?? this.assignedAt,
      chainId: chainId ?? this.chainId,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
