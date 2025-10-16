import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ProductLiveListingDetailView extends ConsumerStatefulWidget {

  final ListingModel data;
  const ProductLiveListingDetailView({super.key,  required this.data });

  @override
  ConsumerState<ProductLiveListingDetailView> createState() => _ProductLiveListingDetailViewState();
}

class _ProductLiveListingDetailViewState extends ConsumerState<ProductLiveListingDetailView> {
  @override
  void initState() {
   
    super.initState();
    Future.microtask((){
      ref.read(productProvider.notifier).setListItem(widget.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    
  // final providerVM = ref.watch(productProvider);
  final ListingModel listData = ref.watch(productProvider.select((e)=>e.listItem)) ?? widget.data;
  final storeNames =  listData.store.storeName;
 List<InfoDataModel> getInfoList(String selectedType) {
  if (selectedType ==  "Best By Products") {
    return [
      InfoDataModel(title: context.tr("discounted_price"), description: "\$${listData.product?.discounted_price}"),

      InfoDataModel(title: context.tr("listing_type"), description: selectedType),
      InfoDataModel(title: context.tr("best_by_date"), description: Helper.selectDateFormat(listData.bestByDate)),
      InfoDataModel(title: context.tr("product_quantity"), description: "${listData.quantity}"),
      InfoDataModel(title: context.tr("current_discount"), description: "${listData.currentDiscount}%"),
      InfoDataModel(title: "Daily Increasing Discount", description: "${listData.dailyIncreasingDiscountPercent}%"),
      InfoDataModel(title: context.tr("listing_start_date"), description: Helper.selectDateFormat(listData.goLiveDate)),
      
    ];
  } else if (selectedType == "Instant Sales") {
    return [
      InfoDataModel(title: context.tr("discounted_price"), description: "\$${listData.product?.discounted_price}"),
      InfoDataModel(title: context.tr("listing_type"), description: selectedType),
      InfoDataModel(title: context.tr("product_quantity"), description: "${listData.quantity}"),
      InfoDataModel(title: context.tr("current_discount"), description: "${listData.currentDiscount}%"),
      InfoDataModel(title: context.tr("hourly_increasing_discount"), description: "${listData.hourlyIncreasingDiscountPercent}%"),
      InfoDataModel(title: context.tr("listing_start_date"), description: Helper.selectDateFormat(listData.goLiveDate)), 
    ];
  } else if (selectedType == "Weighted Items") {
    return [
      InfoDataModel(title: context.tr("listing_type"), description: selectedType),
      InfoDataModel(title: context.tr("best_by_date"), description: Helper.selectDateFormat(listData.bestByDate)),
      InfoDataModel(title: context.tr("product_quantity"), description: "${listData.quantity}"),
     
      ...List.generate(listData.weightedItemsPrices!.length,(index)=>  InfoDataModel(title: "Price ${index + 1}", description: "\$${listData.weightedItemsPrices![index]}")),      
      InfoDataModel(title: "Average Price", description: "\$${listData.averagePrice}"),
      InfoDataModel(title: context.tr("current_discount"), description: "${listData.currentDiscount}%"),
     ];
  } else {
    return [
      InfoDataModel(title: context.tr("discounted_price"), description: "\$${listData.product?.discounted_price}"),
      InfoDataModel(title: context.tr("listing_type"), description: selectedType),
      InfoDataModel(title: context.tr("product_quantity"), description: "${listData.quantity}"),
      InfoDataModel(title: context.tr("current_discount"), description: "${listData.currentDiscount}%"),
      InfoDataModel(title: context.tr("listing_start_date"), description: Helper.selectDateFormat(listData.goLiveDate)), 
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
            
            Consumer(
              builder: (context, ref, child) {
                final res = ref.watch(productProvider.select((e)=>e.updateApiRes)); 
                return CustomButtonWidget(
                  isLoad: res.status == Status.loading,
                  title: listData.status == "APPROVED" ? context.tr("pause") : context.tr("resume"), onPressed: (){
                    ref.read(productProvider.notifier).pauseList(listingId: listData.listingId, status: listData.status == "APPROVED"? "PAUSED" : "APPROVED");
                  });
              }
            ),
            
              
        
              CustomOutlineButtonWidget(title: context.tr("edit"), onPressed: (){
                
                AppRouter.push(ProductAddDetailView(title: context.tr("product_listings_list_product"), type: Helper.getTypeTitle(listData.listingType),data: listData,isLiveListing: true,), );
              
              }),
              CustomButtonWidget(title: context.tr("delete"), onPressed: (){
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
                Text(context.tr("delete"), style: context.textStyle.displayMedium!.copyWith(fontSize: 18.sp)),
                10.ph,
                Text(
                  'context.tr("are_you_sure_you_want_to_delete")',
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
                              ref.read(productProvider.notifier).deleteList(listingId: widget.data.listingId);
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
      title: context.tr("product_listings_list_product"),
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
                ProductTitleWidget(title: context.tr("category"), value: "${listData.product?.category?.title}"),
                ProductTitleWidget(
                  title: context.tr("store"),
                  value: storeNames,
                ),
                ProductTitleWidget(title: context.tr("regular_price"), value: "\$${listData.product?.price}"),

                ...List.generate(getInfoList(Helper.getTypeTitle(listData.listingType)).length, (index)=> ProductTitleWidget(
                  title: getInfoList(Helper.getTypeTitle(listData.listingType))[index].title,
                  value: getInfoList(Helper.getTypeTitle(listData.listingType))[index].description,
                )),
                if(Helper.getTypeTitle(listData.listingType) == "Instant Sales" && listData.schedule!.isNotEmpty)...[
                  10.ph,
                  Row(
                    children: [
                      Text(context.tr("listing_schedule_calendar"), style: context.textStyle.displayMedium,),
                    ],
                  ),
                  ...List.generate(listData.schedule!.length, (index) {
                    final item = listData.schedule![index];
                    return ProductTitleWidget(title: item.day.capitalizeFirst, value: "${item.startTime!.format(context)} - ${item.endTime!.format(context)}");
                  })
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