import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductDetailView extends ConsumerStatefulWidget {
  final bool? isRequest;
  // final String ? type;
  final ListingModel data;
  const ListingProductDetailView({super.key, this.isRequest = false,  required this.data});

  @override
  ConsumerState<ListingProductDetailView> createState() => _ListingProductDetailViewState();
}

class _ListingProductDetailViewState extends ConsumerState<ListingProductDetailView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productProvider.notifier).setListItem(widget.data);
    });
    
  }
  @override
  Widget build(BuildContext context) {
    final listItem = ref.watch(productProvider.select((state) => state.listItem)) ?? widget.data ;
    
    final storeNames = AppConstant.userType == UserType.employee? listItem.product!.store!.storeName: listItem.product!.stores!
    .map((e) => e.storeName)
    .join(', ');
    return CustomScreenTemplate(
      bottomButtonText: "next",
      showBottomButton: true,
      onButtonTap: () {
         if(AppConstant.userType == UserType.employee){
       
       
         if(widget.isRequest!){
           AppRouter.push(ListingProductView(type: Helper.getTypeTitle(listItem.listingType),popTime: 6, isRequest: widget.isRequest!,),settings: RouteSettings(
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
                 if(listItem.product!.stores!.isNotEmpty || listItem.product!.store!.storeName.isNotEmpty || (listItem.listingType != "" && listItem.store.storeName.isNotEmpty)  )...[ ProductTitleWidget(
                  title: "Store",
                  value:listItem.listingType != "" ?listItem.store.storeName :storeNames,
                ),],
                ProductTitleWidget(title: "Category", value: "${widget.data.product?.category?.title}"),
                
                ProductTitleWidget(title: "Regular Price", value: "\$${widget.data.product?.price!.toStringAsFixed(2)}"),

                if(listItem.listingType != "")...[
                  ProductTitleWidget(
                  title: "Listing Type",
                  value: Helper.getTypeTitle(listItem.listingType),
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


