import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingProductDetailView extends StatelessWidget {
  final String type;
  final ListingModel data;
  const PendingProductDetailView({
    super.key,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
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
                    AddDiscountView(isInstant: type == "Instant Sales", data: data,),
                  );
                },
              ),
            if (AppConstant.userType == UserType.employee && data.status == "PENDING_MANAGER_REVIEW")
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
            if (AppConstant.userType == UserType.manager)
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
            if(data.status == "PENDING_MANAGER_REVIEW")
            CustomButtonWidget(
              title: "delete",
              onPressed: () {},
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
                  imageUrl: data.product!.image,
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
                      data.product!.title,
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      data.product!.createdAt!.toReadableString(),
                      style: context.textStyle.bodySmall,
                    ),
                  ],
                ),
                10.ph,
                ProductTitleWidget(
                  title: "Category",
                  value: "${data.product?.category?.title}",
                ),
                ProductTitleWidget(
                  title: "Product Details",
                  value: "${data.product?.description}",
                ),
                ProductTitleWidget(
                  title: "Price",
                  value: "\$${data.product?.price?.toStringAsFixed(2)}",
                ),
                ProductTitleWidget(title: "Listing Type", value: type),
                if (type.toLowerCase().contains("best") ||
                    type.toLowerCase().contains("weighted"))
                  ProductTitleWidget(
                    title: "Best by Date",
                    value: Helper.selectDateFormat(
                      data.bestByDate,
                    ),
                  ),
                ProductTitleWidget(
                  title: "Product Quantity",
                  value: "${data.quantity}",
                ),
                if (type.toLowerCase().contains("weighted")) ...[
                  ProductTitleWidget(title: "Price 1", value: "\$199.99"),
                  ProductTitleWidget(title: "Price 2", value: "\$199.99"),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
