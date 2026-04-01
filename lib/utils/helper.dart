import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class Helper {
  static String selectDateFormat(DateTime? date) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    if (date != null) {
      String month = monthNames[date.month - 1];
      String day = date.day.toString();
      String year = date.year.toString();

      return '$month $day, $year';
    } else {
      return '';
    }
  }

  static void showMessage(
    BuildContext context, {
    required String message,
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showFullScreenLoader(
    BuildContext context, {
    bool dismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black54,
      useRootNavigator: true,
      builder: (context) {
        return PopScope(
          canPop: dismissible,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Card(
                  elevation: 6,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
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

  static String getTypeTitle(String type) {
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

  static Future<File?> compressImage(File file) async {
    try {
      if (kIsWeb) return file;

      final dir = await getTemporaryDirectory();
      final targetPath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        format: CompressFormat.jpeg,
        quality: 60,
        minWidth: 1080,
        minHeight: 1080,
      );

      return result != null ? File(result.path) : file;
    } on MissingPluginException {
      return file;
    } catch (_) {
      return file;
    }
  }
}