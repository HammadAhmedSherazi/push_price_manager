import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';

import '../../../export_all.dart';

class ListingProductDetailView extends StatefulWidget {
  final bool? isRequest;
  final String ? type;
  final ProductSelectionDataModel? product;
  final String? source; // To identify the source flow
  const ListingProductDetailView({super.key, this.isRequest = false, this.type = "", this.product, this.source});

  @override
  State<ListingProductDetailView> createState() => _ListingProductDetailViewState();
}

class _ListingProductDetailViewState extends State<ListingProductDetailView> {
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
      bottomButtonText: "next",
      showBottomButton: true,
      onButtonTap: () {
         if(AppConstant.userType == UserType.employee){
       
       
        if(widget.isRequest!){
           AppRouter.push(ListingProductView(type: widget.type!,popTime: 6,));
       }
       else{
         AppRouter.push(SelectListingTypeView());
       }

       }
      else{
        AppRouter.push(SelectListingTypeView());
      }
        
      },
      title: "Product Listings - List Product",
      child: isLoading 
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
                    // Different fields based on source
                    if (widget.source == "product_listing")
                      ...[
                        ProductTitleWidget(title: "Category", value: selectedProduct!.category ?? "Grocery"),
                        ProductTitleWidget(title: "Best By Price", value: "\$${selectedProduct!.bestBuyPrice.toStringAsFixed(2)}"),
                        ProductTitleWidget(title: "Discounted Price", value: "\$${(selectedProduct!.regularPrice - selectedProduct!.bestBuyPrice).toStringAsFixed(2)}"),
                        ProductTitleWidget(title: "Store", value: "Store 1"),
                        ProductTitleWidget(title: "Product Quantity", value: "4"),
                        ProductTitleWidget(title: "Listing Type", value: "Best By Products"),
                        ProductTitleWidget(title: "Best By Date", value: selectedProduct!.bestByDate),
                      ]
                    else
                      ...[
                        ProductTitleWidget(title: "Store Name", value: "Store 1"),
                        ProductTitleWidget(title: "Category", value: selectedProduct!.category ?? "Grocery"),
                        ProductTitleWidget(title: "Regular Price", value: "\$${selectedProduct!.regularPrice.toStringAsFixed(2)}"),
                        if (widget.isRequest == true)
                          ProductTitleWidget(title: "Listing Type", value: "Best By Date"),
                      ],
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


