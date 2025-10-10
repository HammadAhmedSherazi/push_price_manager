import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductDetailView extends StatelessWidget {
  final bool? isRequest;
  final String ? type;
  final ProductDataModel data;
  const ListingProductDetailView({super.key, this.isRequest = false, this.type = "", required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      bottomButtonText: "next",
      showBottomButton: true,
      onButtonTap: () {
         if(AppConstant.userType == UserType.employee){
       
       
         if(isRequest!){
           AppRouter.push(ListingProductView(type: type!,popTime: 6, isRequest: isRequest!,));
        }
        else{
          AppRouter.push(SelectListingTypeView(),settings: RouteSettings(
            arguments: {
              "product_id": data.id!
            }
          ));
        }

        }
       else{
         AppRouter.push(SelectListingTypeView(), settings: RouteSettings(
            arguments: {
              "product_id": data.id!
            }
          ));
       }
        
      },
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
                DisplayNetworkImage(imageUrl: data.image, height: 60.r, width: 60.r,),
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
                      data.title,
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(data.createdAt!.toReadableString(), style: context.textStyle.bodySmall),
                  ],
                ),
                10.ph,
                ProductTitleWidget(title: "Category", value: "${data.category?.title}"),
                ProductTitleWidget(
                  title: "Product Details",
                  value: data.description,
                ),
                ProductTitleWidget(title: "Price", value: "\$${data.price!.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


