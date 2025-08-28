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
    return 'April 22, 2025';
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

  
}