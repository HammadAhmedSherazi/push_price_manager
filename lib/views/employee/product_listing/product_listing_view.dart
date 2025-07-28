import 'package:flutter/cupertino.dart';

class ProductListingView extends StatefulWidget {
  final ScrollController scrollController;
  const ProductListingView({super.key, required this.scrollController});

  @override
  State<ProductListingView> createState() => _ProductListingViewState();
}

class _ProductListingViewState extends State<ProductListingView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}