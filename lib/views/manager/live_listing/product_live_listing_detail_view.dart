import 'package:push_price_manager/utils/extension.dart';
import '../../../services/product_service.dart';
import '../../../export_all.dart';

class ProductLiveListingDetailView extends StatefulWidget {
  final String type;
  final ProductSelectionDataModel? product;
  const ProductLiveListingDetailView({super.key, required this.type, this.product});

  @override
  State<ProductLiveListingDetailView> createState() => _ProductLiveListingDetailViewState();
}

class _ProductLiveListingDetailViewState extends State<ProductLiveListingDetailView> {
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
 List<InfoDataModel> getInfoList(String selectedType) {
  final bestByDate = selectedProduct?.bestByDate ?? Helper.selectDateFormat(DateTime.now());
  final regularPrice = selectedProduct?.regularPrice ?? 0.0;
  final bestBuyPrice = selectedProduct?.bestBuyPrice ?? 0.0;
  
  if (widget.type ==  "Best By Products") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: bestByDate),
      InfoDataModel(title: "Product Quantity", description: "4"),
      InfoDataModel(title: "Current Discount", description: "10%"),
      InfoDataModel(title: "Daily Increasing Discount", description: "5%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now().add(Duration(days: 20)))),
    ];
  } else if (widget.type == "Instant Sales") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "4"),
      InfoDataModel(title: "Current Discount", description: "10%"),
      InfoDataModel(title: "Hourly Increasing Discount", description: "5%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now().add(Duration(days: 20)))),
    ];
  } else if (selectedType == "Weighted Items") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: bestByDate),
      InfoDataModel(title: "Product Quantity", description: "4"),
      InfoDataModel(title: "Price 1", description: "\$${regularPrice.toStringAsFixed(2)}"),
      InfoDataModel(title: "Price 2", description: "\$${bestBuyPrice.toStringAsFixed(2)}"),
      InfoDataModel(title: "Average Price", description: "\$${((regularPrice + bestBuyPrice) / 2).toStringAsFixed(2)}"),
      InfoDataModel(title: "Current Discount", description: "10%"),
     ];
  } else {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "4"),
      InfoDataModel(title: "Discount", description: "10%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now().add(Duration(days: 20)))),
    ];
  }
}

 
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "",
      onButtonTap: (){
        
      },
      customBottomWidget: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: AppTheme.horizontalPadding 
        ),
        child: Column(
          spacing: 10,
          children: [
            if(widget.type == "Promotional Products")
            CustomButtonWidget(title: "Pause", onPressed: (){}),
            
              
        
              CustomOutlineButtonWidget(title: "edit", onPressed: (){
                AppRouter.push(ProductAddDetailView(title: "Product Listings - List Product", type: widget.type,));
              }),
              CustomButtonWidget(title: "delete", onPressed: (){}, color: Color(0xffB80303),)
           
          ],
        ),
      ),
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
                        Text("Today 3:45pm", style: context.textStyle.bodySmall),
                      ],
                    ),
                    10.ph,
                    ProductTitleWidget(title: "Category", value: selectedProduct!.category ?? "Grocery"),
                    ProductTitleWidget(title: "Regular Price", value: "\$${selectedProduct!.regularPrice.toStringAsFixed(2)}"),
                    ProductTitleWidget(title: "Best Buy Price", value: "\$${selectedProduct!.bestBuyPrice.toStringAsFixed(2)}"),
                ...List.generate(getInfoList(widget.type).length, (index)=> ProductTitleWidget(
                  title: getInfoList(widget.type)[index].title,
                  value: getInfoList(widget.type)[index].description,
                )),
                if(widget.type == "Instant Sales")...[
                  10.ph,
                  Row(
                    children: [
                      Text("Listing Schedule Calender", style: context.textStyle.displayMedium,),
                    ],
                  ),
                  ProductTitleWidget(title: "Monday", value: "09:00 - 18:00")
                ],
                if(widget.type == "Promotional Products")...[
                  10.ph,
                  Row(
                    children: [
                      Expanded(child: Text("Save Discount For Future Listings")),
                      Icon(Icons.check_box_rounded, color: AppColors.secondaryColor,)
                    ],
                  )
                ]
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