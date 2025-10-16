import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class Helper {

  static String selectDateFormat(DateTime? date){
    const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  if(date != null){
      String month = monthNames[date.month - 1];
  String day = date.day.toString();
  String year = date.year.toString();

  return '$month $day, $year';
  }
  else{
    return '';
  }

    // if(date == null){
    //   return "";
    // }
    // return "April 22, 2025";
  }
  static void showMessage(
    BuildContext context, {
    required String message,
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide old one
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating, // Modern UI
      ),
    );
  }
/// Show full-screen loading overlay. Non-dismissible by default.
static void showFullScreenLoader(BuildContext context, {bool dismissible = false}) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    barrierColor: Colors.black54, // semi-transparent background
    useRootNavigator: true,
    builder: (context) {
      // Use WillPopScope if you want to prevent back button dismissal
      return PopScope(
        canPop: dismissible,
        child:  Material(
          color: Colors.transparent, // keep barrierColor visible
          child: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
static  String getTypeTitle(String type) {
  switch (type) {
    case "BEST_BY_PRODUCTS":
      return "Best By Products";
    case "INSTANT_SALE":
      return "Instant Sales";
    case "PROMOTIONAL_PRODUCTS":
      return "Promotional Products";
    case "WEIGHTED_ITEMS":
      return "Weighted Items";
    default:
      return "";
  }
}
static String setType(String type) {
  switch (type) {
    case "Best By Products":
    case "best_by_products":
      return "BEST_BY_PRODUCTS";
    case "Instant Sales":
    case "instant_sales":
      return "INSTANT_SALE";
    case "promotional_products":
    case "Promotional Products":
      return "PROMOTIONAL_PRODUCTS";
    case "weighted_items":
    case "Weighted Items":
      return "WEIGHTED_ITEMS";
    default:
      return "";
  }
}
}