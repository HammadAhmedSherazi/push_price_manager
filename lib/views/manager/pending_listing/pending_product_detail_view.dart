import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingProductDetailView extends ConsumerStatefulWidget {
  // final String type;
  final ListingModel data;
  const PendingProductDetailView({
    super.key,
    // required this.type,
    required this.data,
  });

  @override
  ConsumerState<PendingProductDetailView> createState() => _PendingProductDetailViewState();
}

class _PendingProductDetailViewState extends ConsumerState<PendingProductDetailView> {
  @override
  void initState() {
    super.initState();
     Future.microtask(() {
      ref.read(productProvider.notifier).setListItem(widget.data);
    });
  }
  @override
  Widget build(BuildContext context) {
   
    final listItem = ref.watch(productProvider.select((e)=>e.listItem)) ?? widget.data;
    final storeNames = listItem.store.storeName;
    final type = Helper.getTypeTitle(listItem.listingType);
   
    return CustomScreenTemplate(
      showBottomButton: true,
      customBottomWidget: Padding(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        child: Column(
          spacing: 10,
          children: [
            if (AppConstant.userType == UserType.manager)
              CustomButtonWidget(
                title: context.tr("next"),
                onPressed: () {
                  AppRouter.push(
                    AddDiscountView(
                      isInstant: type == "Instant Sales",
                      isPromotionalDiscount: type == "Promotional Products",
                      data: widget.data,
                    ),
                    fun: (){
                      ref.read(productProvider.notifier).setListItem(listItem);
                    }
                  );
                },
              ),
            if (AppConstant.userType == UserType.employee &&
               ( widget.data.status == "PENDING_MANAGER_REVIEW" || widget.data.status == "PENDING_MANAGER_DISCOUNT"))
              CustomButtonWidget(
                title: context.tr("edit"),
                onPressed: () {
                  AppRouter.push(
                    ProductAddDetailView(
                      title: context.tr("product_listings_list_product"),
                      type: Helper.getTypeTitle(listItem.listingType),
                      data: listItem,
                    ),
                  );
                },
              ),
            if (AppConstant.userType == UserType.manager &&
                (widget.data.status == "PENDING_MANAGER_REVIEW" || widget.data.status == "PENDING_MANAGER_DISCOUNT"))
              CustomOutlineButtonWidget(
                title: context.tr("edit"),
                onPressed: () {
                
                  AppRouter.push(
                    ProductAddDetailView(
                      title: context.tr("pending_listings_list_product"),
                      type: Helper.getTypeTitle(listItem.listingType),
                      data: listItem,
                    ),
                  );
                },
              ),
            if (widget.data.status == "PENDING_MANAGER_REVIEW" || widget.data.status == "PENDING_MANAGER_DISCOUNT")
              CustomButtonWidget(
                title: context.tr("delete"),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color(0xFFF2F7FA),
                        child: Padding(
                          padding: EdgeInsets.all(AppTheme.horizontalPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Delete',
                                style: context.textStyle.displayMedium!
                                    .copyWith(fontSize: 18.sp),
                              ),
                              10.ph,
                              Text(
                                context.tr("are_you_sure_you_want_to_delete"),
                                textAlign: TextAlign.center,
                                style: context.textStyle.bodyMedium!.copyWith(
                                  color: Colors.grey,
                                ),
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
                                        final response = ref.watch(
                                          productProvider.select(
                                            (e) => e.deleteApiRes,
                                          ),
                                        );
                                        return CustomButtonWidget(
                                          title: "Yes",
                                          isLoad:
                                              response.status == Status.loading,
                                          onPressed: () {
                                            ref
                                                .read(productProvider.notifier)
                                                .deleteList(
                                                  listingId: widget.data.listingId,
                                                );
                                          },
                                        );
                                      },
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
                },
                color: Color(0xffB80303),
              ),
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
                DisplayNetworkImage(
                  imageUrl: listItem.product!.image,
                  width: 60.r,
                  height: 60.r,
                ),
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
                      listItem.product!.title,
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    // Text(
                    //   data.product!.createdAt!.toReadableString(),
                    //   style: context.textStyle.bodySmall,
                    // ),
                  ],
                ),
                10.ph,
                ProductTitleWidget(
                  title: context.tr("category"),
                  value: "${listItem.product?.category?.title}",
                ),
                ProductTitleWidget(
                  title: context.tr("store"),
                  value: storeNames,
                ),
                // ProductTitleWidget(
                //   title: "Product Details",
                //   value: "${data.product?.description}",
                // ),
                ProductTitleWidget(
                  title: context.tr("regular_price"),
                  value: "\$${listItem.product?.price?.toStringAsFixed(2)}",
                ),
                ProductTitleWidget(title: context.tr("listing_type"), value: Helper.getTypeTitle(listItem.listingType)),
                if (type.toLowerCase().contains("best") ||
                    type.toLowerCase().contains("weighted"))
                  ProductTitleWidget(
                    title: context.tr("best_by_date"),
                    value: Helper.selectDateFormat(listItem.bestByDate),
                  ),
                ProductTitleWidget(
                  title: context.tr("product_quantity"),
                  value: "${listItem.quantity}",
                ),
                if (type == "Weighted Items" &&
                    listItem.weightedItemsPrices != null &&
                    listItem.weightedItemsPrices!.isNotEmpty) ...[
                  ...List.generate(
                    listItem.weightedItemsPrices!.length,
                    (index) => ProductTitleWidget(
                      title: "Price ${index + 1}",
                      value: "\$${listItem.weightedItemsPrices![index]}",
                    ),
                  ),
                 ProductTitleWidget(
                  title: "Average Price",
                  value: "\$${listItem.averagePrice.toStringAsFixed(2)}",
                ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

}
