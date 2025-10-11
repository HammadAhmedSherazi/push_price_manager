import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductDetailView extends ConsumerWidget {
  final bool? isRequest;
  final String ? type;
  final ListingModel data;
  const ListingProductDetailView({super.key, this.isRequest = false, this.type = "", required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productProvider.select((state) => state.listItem));
    Future.microtask(() {
      ref.read(productProvider.notifier).setListItem(data);
    });
    final listItem = ref.watch(productProvider).listItem ?? data;
    return CustomScreenTemplate(
      bottomButtonText: "next",
      showBottomButton: true,
      onButtonTap: () {
         if(AppConstant.userType == UserType.employee){
       
       
         if(isRequest!){
           AppRouter.push(ListingProductView(type: type!,popTime: 6, isRequest: isRequest!,),settings: RouteSettings(
            arguments: {
              "listing_id": listItem.listingId
            }
          ));
        }
        else{
          AppRouter.push(SelectListingTypeView(),settings: RouteSettings(
            arguments: {
              "product_id": listItem.product!.id!
            }
          ));
        }

        }
       else{
         AppRouter.push(SelectListingTypeView(), settings: RouteSettings(
            arguments: {
              "product_id": listItem.product!.id!
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
                DisplayNetworkImage(imageUrl: listItem.product!.image, height: 60.r, width: 60.r,),
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
                    // Text(data.createdAt!.toReadableString(), style: context.textStyle.bodySmall),
                  ],
                ),
                10.ph,
                ProductTitleWidget(title: "Category", value: "${data.product?.category?.title}"),
                
               if(listItem.store.storeName.isNotEmpty)...[ ProductTitleWidget(
                  title: "Store",
                  value: listItem.store.storeName,
                ),],
                // ProductTitleWidget(
                //   title: "Product Details",
                //   value: data.description,
                // ),
                ProductTitleWidget(title: "Regular Price", value: "\$${data.product?.price!.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


