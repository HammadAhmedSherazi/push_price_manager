import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ProductLiveListingDetailView extends ConsumerWidget {

  final ListingModel data;
  const ProductLiveListingDetailView({super.key,  required this.data });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask((){
      ref.read(productProvider.notifier).setListItem(data);
    });
  final providerVM = ref.watch(productProvider);
  final ListingModel listData = providerVM.listItem ?? data;
 List<InfoDataModel> getInfoList(String selectedType) {
  if (selectedType ==  "Best By Products") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: Helper.selectDateFormat(listData.bestByDate)),
      InfoDataModel(title: "Product Quantity", description: "${listData.quantity}"),
      InfoDataModel(title: "Current Discount", description: "${listData.currentDiscount}%"),
      InfoDataModel(title: "Daily Increasing Discount", description: "${listData.dailyIncreasingDiscountPercent}%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(listData.goLiveDate)),
    ];
  } else if (selectedType == "Instant Sales") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "${listData.quantity}"),
      InfoDataModel(title: "Current Discount", description: "${listData.currentDiscount}%"),
      InfoDataModel(title: "Hourly Increasing Discount", description: "${listData.hourlyIncreasingDiscountPercent}%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(listData.goLiveDate)), 
    ];
  } else if (selectedType == "Weighted Items") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: Helper.selectDateFormat(listData.bestByDate)),
      InfoDataModel(title: "Product Quantity", description: "${listData.quantity}"),
     
      ...List.generate(listData.weightedItemsPrices!.length,(index)=>  InfoDataModel(title: "Price ${index + 1}", description: "\$${listData.weightedItemsPrices![index]}")),      
      InfoDataModel(title: "Average Price", description: "\$${listData.averagePrice}"),
      InfoDataModel(title: "Current Discount", description: "${listData.currentDiscount}%"),
     ];
  } else {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "${listData.quantity}"),
      InfoDataModel(title: "Current Discount", description: "${listData.currentDiscount}%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(listData.goLiveDate)), 
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
            if(Helper.getTypeTitle(listData.listingType) == "Promotional Products")
            CustomButtonWidget(title: "Pause", onPressed: (){}),
            
              
        
              CustomOutlineButtonWidget(title: "edit", onPressed: (){
                AppRouter.push(ProductAddDetailView(title: "Product Listings - List Product", type: Helper.getTypeTitle(listData.listingType),data: listData,));
              }),
              CustomButtonWidget(title: "delete", onPressed: (){
                // void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFFF2F7FA),
          child: Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Delete', style: context.textStyle.displayMedium!.copyWith(fontSize: 18.sp)),
                10.ph,
                Text(
                  'Are you sure you want to delete?',
                  textAlign: TextAlign.center,
                  style: context.textStyle.bodyMedium!.copyWith(color: Colors.grey),
                ),
                30.ph,
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomOutlineButtonWidget(
                        title: "cancel",
                        onPressed: () => AppRouter.back(),
                      ),
                    ),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final response = ref.watch(productProvider.select((e)=>e.deleteApiRes));
                          return CustomButtonWidget(
                            title: "Yes",
                            isLoad: response.status == Status.loading,
                            onPressed: () {
                              ref.read(productProvider.notifier).deleteList(listingId: data.listingId);
                            },
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  // }
              }, color: Color(0xffB80303),)
           
          ],
        ),
      ),
      title: "Product Listings - List Product",
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: AppTheme.horizontalPadding),
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            height: context.screenheight * 0.18,
            color: AppColors.primaryAppBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DisplayNetworkImage(imageUrl: listData.product!.image, width: 60.r, height: 60.r,)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 10.r,
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listData.product!.title,
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    // Text("Today 3:45pm", style: context.textStyle.bodySmall),
                  ],
                ),
                10.ph,
                ProductTitleWidget(title: "Category", value: "ABC Category"),
                ProductTitleWidget(
                  title: "Store",
                  value: "${listData.store.storeName}",
                ),
                ProductTitleWidget(title: "Price", value: "\$${listData.product?.price}"),
                ...List.generate(getInfoList(Helper.getTypeTitle(listData.listingType)).length, (index)=> ProductTitleWidget(
                  title: getInfoList(Helper.getTypeTitle(listData.listingType))[index].title,
                  value: getInfoList(Helper.getTypeTitle(listData.listingType))[index].description,
                )),
                if(Helper.getTypeTitle(listData.listingType) == "Instant Sales")...[
                  10.ph,
                  Row(
                    children: [
                      Text("Listing Schedule Calender", style: context.textStyle.displayMedium,),
                    ],
                  ),
                  ProductTitleWidget(title: "Monday", value: "09:00 - 18:00")
                ],
                if(Helper.getTypeTitle(listData.listingType) == "Promotional Products")...[
                  10.ph,
                  Row(
                    children: [
                      Expanded(child: Text("Save Discount For Future Listings")),
                      Icon(Icons.check_box_rounded, color: AppColors.secondaryColor,)
                    ],
                  )
                ]
              ],

            ),
          ),
        ],
      ),
    );
 
  }
}