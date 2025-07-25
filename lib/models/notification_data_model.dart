class NotificationDataModel {
  final String title;
  final String description;
  final int count;

  NotificationDataModel({
    required this.title,
    required this.description,
    required this.count,
  });
}

class StoreProductNotification {
  final String title;
  final String storeName;
  final String storeAddress;

  StoreProductNotification({
    required this.title,
    required this.storeName,
    required this.storeAddress,
  });
}