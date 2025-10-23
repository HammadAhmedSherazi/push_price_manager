

import 'package:intl/intl.dart';

import '../export_all.dart';

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
    if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('username_is_required');
    if (trim().length < 3) return AppRouter.navKey.currentContext!.tr('username_must_be_at_least_3_characters');
    final regex = RegExp(r'^[A-Za-z\s]+$');
    if (!regex.hasMatch(trim())) {
      return AppRouter.navKey.currentContext!.tr('username_should_only_contain_alphabets');
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
    if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('email_is_required');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trim())) return AppRouter.navKey.currentContext!.tr('enter_a_valid_email_address');
    return null;
  }

  /// ✅ Password validation
  String? validatePassword() {
    if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('password_is_required');
    if (trim().length < 6) return AppRouter.navKey.currentContext!.tr('password_must_be_at_least_6_characters');
    // final hasLetter = contains(RegExp(r'[A-Za-z]'));
    // final hasNumber = contains(RegExp(r'[0-9]'));
    // if (!hasLetter || !hasNumber) {
    //   return 'Password must contain letters and numbers';
    // }
    return null;
  }

  /// ✅ Confirm password
  String? validateConfirmPassword(String originalPassword) {
    if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('confirm_password_is_required');
    if (this != originalPassword) return AppRouter.navKey.currentContext!.tr('passwords_do_not_match');
    return null;
  }

  /// ✅ Phone number validation (accepts only digits, 10-15 length)

  String? validatePhoneNumber() {
    final input = trim();
    if (input.isEmpty) return AppRouter.navKey.currentContext!.tr('phone_number_is_required');

    final regex = RegExp(r'^[0-9]{10,15}$'); // ✅ only 10–15 digits
    if (!regex.hasMatch(input)) {
      return AppRouter.navKey.currentContext!.tr('enter_a_valid_phone_number_10_15_digits');
    }
    return null;
  }
  /// ✅ Weight validation
 String? validateWeight() {
  if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('weight_is_required');

  // ✅ Only numbers with optional decimal part
  final weightRegex = RegExp(r'^\d+(\.\d+)?$');
  if (!weightRegex.hasMatch(trim())) {
    return AppRouter.navKey.currentContext!.tr('enter_a_valid_weight_numbers_only_e_g_70_or_70_5');
  }

  final value = double.tryParse(trim());
  if (value == null || value < 30 || value > 300) {
    return AppRouter.navKey.currentContext!.tr('weight_must_be_between_30_and_300');
  }

  return null;
}

  /// ✅ Weight validation
String? validateHeight() {
  if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('height_is_required');

  final heightRegex = RegExp(r'^\d+(\.\d+)?$');
  if (!heightRegex.hasMatch(trim())) {
    return AppRouter.navKey.currentContext!.tr('enter_a_valid_height_e_g_5_6');
  }

  final value = double.tryParse(trim());
  if (value == null || value < 3.0 || value > 8.0) {
    return AppRouter.navKey.currentContext!.tr('height_must_be_between_3_0_and_8_0_feet');
  }

  return null;
}
String? validateCurrentDiscount() {
  final value = double.tryParse(trim());
  if (value == null) return AppRouter.navKey.currentContext!.tr('discount_is_required');

  // ✅ Ensure it’s within a reasonable range (0–100%)
  if (value < 0 || value > 100) {
    return AppRouter.navKey.currentContext!.tr('discount_must_be_between_0_and_100');
  }

  return null; // ✅ Valid discount
}
String? validateDate() {
  if (trim().isEmpty) return AppRouter.navKey.currentContext!.tr('date_is_required');

  try {
    final date = DateTime.tryParse(trim());
    if(date == null) return null;


    final now = DateTime.now();

    // ✅ Optional: disallow past or unrealistic future dates
    if (date.isBefore(DateTime(now.year, now.month, now.day))) {
      return AppRouter.navKey.currentContext!.tr('date_cannot_be_in_the_past');
    }

    if (date.isAfter(DateTime(now.year + 2))) {
      return AppRouter.navKey.currentContext!.tr('date_is_too_far_in_the_future');
    }

    return null; // ✅ Valid date
  } catch (e) {
    return AppRouter.navKey.currentContext!.tr('enter_a_valid_date');
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
extension CapitalizeExtension on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
enum OrderStatus {
  inProcess,
  completed,
  cancelled,
}

