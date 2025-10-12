import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingProductDetailView extends ConsumerWidget {
  final String type;
  final ListingModel data;
  const PendingProductDetailView({
    super.key,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() {
      ref.read(productProvider.notifier).setListItem(data);
    });
    final listItem = ref.watch(productProvider).listItem ?? data;
    return CustomScreenTemplate(
      showBottomButton: true,
      customBottomWidget: Padding(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        child: Column(
          spacing: 10,
          children: [
            if (AppConstant.userType == UserType.manager)
              CustomButtonWidget(
                title: "next",
                onPressed: () {
                  AppRouter.push(
                    AddDiscountView(
                      isInstant: type == "Instant Sales",
                      data: data,
                    ),
                  );
                },
              ),
            if (AppConstant.userType == UserType.employee &&
                data.status == "PENDING_MANAGER_REVIEW")
              CustomButtonWidget(
                title: "edit",
                onPressed: () {
                  AppRouter.push(
                    ProductAddDetailView(
                      title: "Product Listings - List Product",
                      type: type,
                      data: data,
                    ),
                  );
                },
              ),
            if (AppConstant.userType == UserType.manager &&
                data.status == "PENDING_MANAGER_REVIEW")
              CustomOutlineButtonWidget(
                title: "edit",
                onPressed: () {
                  AppRouter.push(
                    ProductAddDetailView(
                      title: "Pending Listings - List Product",
                      type: type,
                      data: data,
                    ),
                  );
                },
              ),
            if (data.status == "PENDING_MANAGER_REVIEW")
              CustomButtonWidget(
                title: "delete",
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
                                'Are you sure you want to delete?',
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
                                                  listingId: data.listingId,
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
                  title: "Category",
                  value: "${listItem.product?.category?.title}",
                ),
                ProductTitleWidget(
                  title: "Store",
                  value: listItem.store.storeName,
                ),
                // ProductTitleWidget(
                //   title: "Product Details",
                //   value: "${data.product?.description}",
                // ),
                ProductTitleWidget(
                  title: "Price",
                  value: "\$${listItem.product?.price?.toStringAsFixed(2)}",
                ),
                ProductTitleWidget(title: "Listing Type", value: type),
                if (type.toLowerCase().contains("best") ||
                    type.toLowerCase().contains("weighted"))
                  ProductTitleWidget(
                    title: "Best by Date",
                    value: Helper.selectDateFormat(listItem.bestByDate),
                  ),
                ProductTitleWidget(
                  title: "Product Quantity",
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
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
