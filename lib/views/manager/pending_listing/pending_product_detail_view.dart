import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingProductDetailView extends StatelessWidget {
  final String type;
  const PendingProductDetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      customBottomWidget: Padding(
        padding:  EdgeInsets.all(AppTheme.horizontalPadding),
        child: Column(
          spacing: 10,
          children: [
            if(AppConstant.userType == UserType.manager)
            CustomButtonWidget(title: "next", onPressed: (){
              
            }),
            if(AppConstant.userType == UserType.employee)
            CustomButtonWidget(title: "edit", onPressed: (){
               AppRouter.push(ProductAddDetailView(title: "Product Listings - List Product"));
            }),
            if(AppConstant.userType == UserType.manager)
            CustomOutlineButtonWidget(title: "edit", onPressed: (){
              AppRouter.push(ProductAddDetailView(title: "Pending Listings - List Product"));
            }),
            CustomButtonWidget(title: "delete", onPressed: (){}, color: Color(0xffB80303),)
          ],
        ),
      ),
      title: "Product Listings - List Product", child: 
      ListView(
        padding: EdgeInsets.symmetric(vertical: AppTheme.horizontalPadding),
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            height: context.screenheight * 0.18,
            color: AppColors.primaryAppBarColor,
            child: Image.asset(Assets.groceryBag),
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
                      "ABC Product",
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text("Today 3:45pm", style: context.textStyle.bodySmall),
                  ],
                ),
                10.ph,
                ProductTitleWidget(title: "Category", value: "ABC Category"),
                ProductTitleWidget(
                  title: "Product Details",
                  value: "Lorem Ipsum Dor",
                ),
                ProductTitleWidget(title: "Price", value: "\$199.99"),
                ProductTitleWidget(title: "Listing Type", value: type),
                if(type.toLowerCase().contains("best"))
                ProductTitleWidget(title: "Best by Date", value: "April 22, 2025"),
                ProductTitleWidget(title: "Product Quantity", value: "2"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}