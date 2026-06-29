import 'package:flutter/material.dart';

/// Full-width app — no max-width constraint on tablet.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
