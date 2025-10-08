class ApiEndpoints {
  static const String login = "admin/staff/login";
  static const String getProducts = "admin/products/";
  static const String getDataBaseProducts = "admin/products/employee-product-database";
  static const String getProductDetailByBarCode = "admin/products/barcode/";
  static const String listings = "admin/listings/";
  static const String myListings = "${ApiEndpoints.listings}my-listings";
  static const String pendingEmployeeTasks = "${ApiEndpoints.listings}pending-employee-tasks";
  static const String suggestionsDiscount = "${ApiEndpoints.listings}suggestions/discount/";
  static const String pendingReview = "${ApiEndpoints.listings}pending/review";

}