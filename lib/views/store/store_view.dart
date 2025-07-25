import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  int selectIndex = 0;
  int count = 0;
  num price = 0;
  final List<String> listType = [
    "Best by Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products",
  ];
  final List<ProductPurchasingDataModel> products = [
    ProductPurchasingDataModel(
      title: "ABC Product",
      description: "ABC Category",
      image: Assets.groceryBag,
      quantity: 0,
      discountAmount: 80.00,
      price: 99.99,
    ),
    ProductPurchasingDataModel(
      title: "ABC Product",
      description: "ABC Category",
      image: Assets.groceryBag,
      quantity: 0,
      discountAmount: 80.00,
      price: 99.99,
    ),
  ];
  List<ProductPurchasingDataModel> cartList = [];

  addQuantity(index) {
    final product = products[index];
    setState(() {
      
      products[index] = product.copyWith(quantity: product.quantity + 1);
      // cartList[index] = products[index];
      price += product.discountAmount;
      count++;

    });
  }
  removeQuantity(index){
    final product = products[index];
    if(product.quantity >0){
       setState(() {
      
      products[index] = product.copyWith(quantity: product.quantity - 1);
      // cartList[index] = products[index];
      price -= product.discountAmount;
      count--;
    });
    }
    else{
      setState(() {
        cartList.removeAt(index);
        if(count >0){
          count--;
          price -= product.discountAmount;
        }        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: count >0? Padding(padding: EdgeInsets.all(AppTheme.horizontalPadding), child: CustomButtonWidget(title: "", onPressed: (){
        AppRouter.push(CartView());
      }, child: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 0.8
                )
              ),
              alignment: Alignment.center,
              child: Text("$count", style: context.textStyle.titleSmall!.copyWith(
                color: Colors.white
              ),),
            ),
            Text("View Your Cart", style: context.textStyle.bodyMedium!.copyWith(
              color: Colors.white
            ),),
            Text("\$$price", style: context.textStyle.bodySmall!.copyWith(
              color: Colors.white
            ),),
          ],
        ),
      ),),) : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.screenheight * 0.10),
        child:
            // Container(
            //   decoration: BoxDecoration(
            //     color: AppColors.primaryAppBarColor,
            //     borderRadius: BorderRadius.vertical(
            //       bottom: Radius.circular(30.r)
            //     )
            //   ),
            // )
            AppBar(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30.r),
                ),
              ),
              backgroundColor: AppColors.primaryAppBarColor,
              leadingWidth: context.screenwidth * 0.35,
              leading: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.horizontalPadding,
                      vertical: 10.r,
                    ),
                    child: CustomBackWidget(),
                  ),
                ],
              ),
              centerTitle: true,
              title: GestureDetector(
                onTap: (){
                  AppRouter.push(StoreDetailView());
                },
                child: Text("Abc Store", style: context.textStyle.displayMedium)),
              actions: [
                UserProfileWidget(
                  radius: 18.r,
                  imageUrl: Assets.userImage,
                  borderWidth: 2,
                ),
                20.pw,
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(context.screenheight),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.r),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.locationIcon),
                      Text(
                        'ABC, Street Lorem Ipsum, NY City',
                        style: context.textStyle.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectChipWidget(
            items: listType,
            selectedIndex: selectIndex,
            onSelected: (index) {
              setState(() {
                selectIndex = index;
              });
            },
          ),
          5.ph,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Text(
              listType[selectIndex],
              style: context.textStyle.displayMedium,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(AppTheme.horizontalPadding),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: (){
                    AppRouter.push(ProductDetailView());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.r,
                      horizontal: 20.r,
                    ),
                    decoration: AppTheme.productBoxDecoration,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: product.quantity > 0? Container(
                        // height: 30.h,
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30.r),
                            right: Radius.circular(30.r)
                          ),
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderColor
                          )
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            GestureDetector(
                              onTap: () {
                                removeQuantity(index);
                              },
                              child: Icon(Icons.delete, color: Color(0xffAE1B0D),)),
                            Text("${product.quantity}", style: context.textStyle.displayMedium,),
                            GestureDetector(
                              onTap: (){
                                addQuantity(index);
                              },
                              child: SvgPicture.asset(Assets.addCircleIcon)),
                          ],
                        ),
                      ): IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity(
                              horizontal: -4.0,
                              vertical: -4.0,
                            ),
                            onPressed: () {
                              addQuantity(index);
                            },
                            icon: SvgPicture.asset(Assets.addCircleIcon),
                          ),
                        ),
                        Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(Assets.groceryBag, width: 57.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${product.title} ",
                                          style: context.textStyle.displayMedium,
                                        ),
                                        TextSpan(
                                          text: " 20% Off",
                                          style: context.textStyle.titleSmall!
                                              .copyWith(
                                                color: AppColors.secondaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.ph,
                                  Text.rich(
                                    textAlign: TextAlign.end,
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "\$${product.discountAmount} ",
                                          style: context.textStyle.displayMedium!
                                              .copyWith(
                                                color: AppColors.secondaryColor,
                                              ),
                                        ),
                                        TextSpan(
                                          text: "\$${product.price}",
                                          style: context.textStyle.displayMedium!
                                              .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Color.fromRGBO(
                                                  91,
                                                  91,
                                                  91,
                                                  1,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.ph,
                                  Text(
                                    listType[selectIndex] == "Best by Products"
                                        ? "Best By: April 25, 2025"
                                        : product.description,
                                    style: context.textStyle.bodySmall!.copyWith(
                                      color: AppColors.primaryTextColor
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                  
                                  // 2.ph,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.ph,
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}
