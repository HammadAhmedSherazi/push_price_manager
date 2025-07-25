import 'package:flutter/material.dart';
import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/widget/custom_app_bar_widget.dart';

class PendingListingView extends StatefulWidget {
  final ScrollController scrollController;
  const PendingListingView({super.key, required this.scrollController});

  @override
  State<PendingListingView> createState() => _PendingListingViewState();
}

class _PendingListingViewState extends State<PendingListingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(height: context.screenheight * 0.15, title: "Listing Request - Select Product", children: []),
    );
  }
}