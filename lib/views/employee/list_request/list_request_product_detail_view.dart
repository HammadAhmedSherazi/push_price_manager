import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';

import '../../../export_all.dart';

class ListRequestProductDetailView extends StatefulWidget {
  final String type;
  final ProductSelectionDataModel? product;
  const ListRequestProductDetailView({super.key, required this.type, this.product});

  @override
  State<ListRequestProductDetailView> createState() => _ListRequestProductDetailViewState();
}

class _ListRequestProductDetailViewState extends State<ListRequestProductDetailView> {
  RealProductDataModel? selectedProduct;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      if (widget.product != null) {
        // Convert ProductSelectionDataModel to RealProductDataModel
        final products = await ProductService.getAllProducts();
        selectedProduct = products.firstWhere(
          (product) => product.item == widget.product!.title,
          orElse: () => products.first,
        );
      } else {
        final products = await ProductService.getAllProducts();
        if (products.isNotEmpty) {
          selectedProduct = products.first;
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: (){
        AppRouter.push(ListingProductView(type: widget.type, popTime: 2,));
      },
      title: "Product Listings - List Product", child: 
      isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: AppTheme.horizontalPadding),
            children: [
              Container(
                padding: EdgeInsets.all(30.r),
                height: context.screenheight * 0.18,
                color: AppColors.primaryAppBarColor,
                child: selectedProduct?.image != null 
                  ? selectedProduct!.image!.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: selectedProduct!.image!,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image, size: 50.r),
                        ),
                        errorWidget: (context, url, error) => Image.asset(Assets.groceryBag),
                      )
                    : Image.asset(
                        selectedProduct!.image!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(Assets.groceryBag);
                        },
                      )
                  : Image.asset(Assets.groceryBag),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10.r,
                  horizontal: AppTheme.horizontalPadding,
                ),
                child: selectedProduct != null ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            selectedProduct!.item,
                            style: context.textStyle.displayMedium!.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Text("", style: context.textStyle.bodySmall),
                      ],
                    ),
                    10.ph,
                    ProductTitleWidget(title: "Category", value: selectedProduct!.category ?? "Grocery"),
                    ProductTitleWidget(title: "Regular Price", value: "\$${selectedProduct!.regularPrice.toStringAsFixed(2)}"),
                    // ProductTitleWidget(title: "Listing Type", value: widget.type),
                  ],
                ) : Column(
                  children: [
                    Text("No product data available", style: context.textStyle.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}