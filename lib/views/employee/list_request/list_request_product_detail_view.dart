import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListRequestProductDetailView extends StatelessWidget {
  final String type;
  const ListRequestProductDetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: (){
        AppRouter.push(ListingProductView(type: type, popTime: 2,));
      },
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
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}