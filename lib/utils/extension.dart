

import '../export_all.dart';
import 'package:intl/intl.dart';

extension Spacing on num {
  SizedBox get ph => SizedBox(height: toDouble().h);

  SizedBox get pw => SizedBox(width: toDouble().w);
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;

  TextTheme get textStyle => theme.textTheme;

  InputDecorationThemeData get inputTheme => theme.inputDecorationTheme;

  BottomNavigationBarThemeData get bottomAppStyle =>
      theme.bottomNavigationBarTheme;

  double get screenwidth => MediaQuery.of(this).size.width;
  double get screenheight => MediaQuery.of(this).size.height;
}
extension StringExtension on String {
  String toTitleCase() {
    return toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}
extension StringValidation on String {
  /// ✅ Only alphabets (A-Z a-z) and spaces allowed
  String? validateAlphabetOnly(String fieldName) {
    if (trim().isEmpty) return '$fieldName is required';
    final regex = RegExp(r'^[A-Za-z\s]+$');
    if (!regex.hasMatch(trim())) {
      return '$fieldName should only contain alphabets';
    }
    return null;
  }

  /// ✅ Username must be at least 3 characters & alphabets only
  String? validateUsername() {
    if (trim().isEmpty) return 'Username is required';
    if (trim().length < 3) return 'Username must be at least 3 characters';
    final regex = RegExp(r'^[A-Za-z\s]+$');
    if (!regex.hasMatch(trim())) {
      return 'Username should only contain alphabets';
    }
    return null;
  }
  String? validateGeneralField({required String fieldName, required int minStrLen }) {
    if (trim().isEmpty) return '$fieldName is required';
    if (trim().length < minStrLen) return '$fieldName must be at least $minStrLen characters';
   
    return null;
  }
  

  /// ✅ Email validation
  String? validateEmail() {
    if (trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trim())) return 'Enter a valid email address';
    return null;
  }

  /// ✅ Password validation
  String? validatePassword() {
    if (trim().isEmpty) return 'Password is required';
    if (trim().length < 6) return 'Password must be at least 6 characters';
    // final hasLetter = contains(RegExp(r'[A-Za-z]'));
    // final hasNumber = contains(RegExp(r'[0-9]'));
    // if (!hasLetter || !hasNumber) {
    //   return 'Password must contain letters and numbers';
    // }
    return null;
  }

  /// ✅ Confirm password
  String? validateConfirmPassword(String originalPassword) {
    if (trim().isEmpty) return 'Confirm password is required';
    if (this != originalPassword) return 'Passwords do not match';
    return null;
  }

  /// ✅ Phone number validation (accepts only digits, 10-15 length)
  
  String? validatePhoneNumber() {
    final input = trim();
    if (input.isEmpty) return 'Phone number is required';

    final regex = RegExp(r'^[0-9]{10,15}$'); // ✅ only 10–15 digits
    if (!regex.hasMatch(input)) {
      return 'Enter a valid phone number (10-15 digits)';
    }
    return null;
  }
  /// ✅ Weight validation
 String? validateWeight() {
  if (trim().isEmpty) return 'Weight is required';

  // ✅ Only numbers with optional decimal part
  final weightRegex = RegExp(r'^\d+(\.\d+)?$');
  if (!weightRegex.hasMatch(trim())) {
    return 'Enter a valid weight (numbers only, e.g. 70 or 70.5)';
  }

  final value = double.tryParse(trim());
  if (value == null || value < 30 || value > 300) {
    return 'Weight must be between 30 and 300';
  }

  return null;
}

  /// ✅ Weight validation
String? validateHeight() {
  if (trim().isEmpty) return 'Height is required';

  final heightRegex = RegExp(r'^\d+(\.\d+)?$');
  if (!heightRegex.hasMatch(trim())) {
    return 'Enter a valid height (e.g. 5.6)';
  }

  final value = double.tryParse(trim());
  if (value == null || value < 3.0 || value > 8.0) {
    return 'Height must be between 3.0 and 8.0 feet';
  }

  return null;
}
String? validateCurrentDiscount() {
  final value = double.tryParse(trim());
  if (value == null) return 'Discount is required';

  // ✅ Ensure it’s within a reasonable range (0–100%)
  if (value < 0 || value > 100) {
    return 'Discount must be between 0 and 100';
  }

  return null; // ✅ Valid discount
}
String? validateDate() {
  if (trim().isEmpty) return 'Date is required';

  try {
    final date = DateTime.tryParse(trim());
    if(date == null) return null;


    final now = DateTime.now();

    // ✅ Optional: disallow past or unrealistic future dates
    if (date.isBefore(DateTime(now.year, now.month, now.day))) {
      return 'Date cannot be in the past';
    }

    if (date.isAfter(DateTime(now.year + 2))) {
      return 'Date is too far in the future';
    }

    return null; // ✅ Valid date
  } catch (e) {
    return 'Enter a valid date (e.g. 2025-10-08)';
  }
}

}
extension ReadableDateTime on DateTime {
  String toReadableString() {
    final now = DateTime.now();
    final localDate = toLocal();

    final dateFormat = DateFormat('MM/dd/yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final difference = now.difference(localDate).inDays;

    String dayLabel;
    if (difference == 0 &&
        localDate.day == now.day &&
        localDate.month == now.month &&
        localDate.year == now.year) {
      dayLabel = 'Today';
    } else if (difference == 1 ||
        (now.day - localDate.day == 1 &&
            localDate.month == now.month &&
            localDate.year == now.year)) {
      dayLabel = 'Yesterday';
    } else {
      dayLabel = dateFormat.format(localDate);
    }

    return '$dayLabel ${timeFormat.format(localDate)}';
  }
}
enum OrderStatus {
  inProcess,
  completed,
  cancelled,
}

