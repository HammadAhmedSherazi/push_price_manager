import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/main.dart' as app;

Future<void> _snap(
  IntegrationTestWidgetsFlutterBinding binding,
  String name,
) async {
  await binding.convertFlutterSurfaceToImage();
  await binding.takeScreenshot(name);
}

Future<Map<String, String>?> _readCredentials() async {
  const user = String.fromEnvironment('SCREENSHOT_USER');
  const pass = String.fromEnvironment('SCREENSHOT_PASS');
  if (user.isNotEmpty && pass.isNotEmpty) {
    return {'username': user, 'password': pass};
  }

  final file = File('tool/screenshot_credentials.json');
  if (!file.existsSync()) return null;

  final map = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  final username = map['username'] as String?;
  final password = map['password'] as String?;
  if (username == null || password == null) return null;
  return {'username': username, 'password': password};
}

Future<void> _tapBottomTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture Play Store phone screenshots', (tester) async {
    await SharedPreferenceManager.init();
    await SharedPreferenceManager.instance.clear();

    final credentials = await _readCredentials();

    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await _snap(binding, '01_onboarding');

    await tester.tap(find.text('GET STARTED'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('SKIP'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await _snap(binding, '07_sign_in');

    if (credentials == null) return;

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), credentials['username']!);
    await tester.enterText(fields.at(1), credentials['password']!);
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    final isEmployee = AppConstant.userType == UserType.employee;
    if (isEmployee) {
      await _snap(binding, '02_home_staff');
      await _tapBottomTab(tester, 'Listing Requests');
      await _snap(binding, '03_listing_requests');
      await _tapBottomTab(tester, 'Product Listing');
      await _snap(binding, '04_product_listing');
      await _tapBottomTab(tester, 'Profile');
      await _snap(binding, '06_profile_staff');
    } else {
      await _snap(binding, '01_home_manager');
      await _tapBottomTab(tester, 'Pending Listings');
      await _snap(binding, '03_listing_requests');
      await _tapBottomTab(tester, 'Live Listings');
      await _snap(binding, '04_product_listing');
      await _tapBottomTab(tester, 'Profile');
      await _snap(binding, '05_profile_manager');
    }
  });
}
