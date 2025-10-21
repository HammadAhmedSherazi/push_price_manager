class ApiEndpoints {
  static const String adminStaff = "admin/staff/";
  static const String login = "${adminStaff}login";
  static const String getProducts = "admin/products/";
  static const String getCatrgories = "${getProducts}categories";
  static const String getEmployeeDataBaseProducts = "${getProducts}employee-product-database";
  static const String getManagerDataBaseProducts = "${getProducts}manager-product-database";
  static const String getProductDetailByBarCode = "${getProducts}barcode/";
  static const String listings = "admin/listings/";
  static const String myListings = "${listings}my-listings";
  static const String pendingEmployeeTasks = "${ApiEndpoints.listings}pending-employee-tasks";
  static const String managerCreate = "${ApiEndpoints.listings}manager-create";
  static String suggestionsDiscount(int id)=> "${ApiEndpoints.listings}suggestions/discount/$id";
  static const String pendingReview = "${ApiEndpoints.listings}pending/review";
  static const String liveList = "${ApiEndpoints.listings}live";
  static const String review = "${ApiEndpoints.listings}review";
  static String updateEmployeeListRequest(int id)=> "${ApiEndpoints.listings}$id/employee-details";
  static const String getMyStore = "${adminStaff}my-stores";
  static String updateStatus(int id)=>"${ApiEndpoints.listings}$id/status";


}