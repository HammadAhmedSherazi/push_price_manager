import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int quantity = 1;
  addQuantity(){
   
    setState(() {
       quantity++;
    });
  }
  removeQuantity(){
    if(quantity > 1){
      setState(() {
        quantity--;
    });
    }
    
  }
  ProductPurchasingDataModel product = ProductPurchasingDataModel(
      title: "ABC Product",
      description: "ABC Category",
      image: Assets.groceryBag,
      quantity: 1,
      discountAmount: 80.00,
      price: 99.99,
    );
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      onButtonTap: (){
        AppRouter.pushReplacement(OrderSuccessModifiedView(
          message: "Your Order Has Been Placed Successfully!"
,
        ));
      },
      bottomButtonText: "place order",
      title: "Cart", child: Column(
      children: [
        Expanded(child: ListView(
          padding: EdgeInsets.all(AppTheme.horizontalPadding),
          children: [
            Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 15.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Color.fromRGBO(243, 243, 243, 1),
            ),
            child: Row(
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
                              style: context.textStyle.titleSmall!.copyWith(
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
                              style: context.textStyle.displayMedium!.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: "\$${product.price}",
                              style: context.textStyle.displayMedium!.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.ph,
                      Text(
                        "Best By: April 25, 2025",
                        style: context.textStyle.bodySmall!.copyWith(
                          color: AppColors.primaryTextColor.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),

                      // 2.ph,
                    ],
                  ),
                ),
                Container(
                  // height: 30.h,
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30.r),
                      right: Radius.circular(30.r),
                    ),
                    border: Border.all(width: 1, color: AppColors.borderColor),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeQuantity();
                        },
                        child: SvgPicture.asset(Assets.minusSquareIcon),
                      ),
                      Text("$quantity", style: context.textStyle.displayMedium),
                      GestureDetector(
                        onTap: () {
                          addQuantity();
                        },
                        child: SvgPicture.asset(Assets.plusSquareIcon),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.ph,
          Text("Promotional Products", style: context.textStyle.headlineMedium,),
                  10.ph,
                  SizedBox(
                    height: 125.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index)=>Container(

                      padding: EdgeInsets.symmetric(
                        horizontal: 10.r,
                        vertical: 15.r
                      ),
                      height: double.infinity,
                      width: context.screenwidth * 0.35,
                      decoration: AppTheme.productBoxDecoration,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: 0,
                            bottom: -13.r,
                            child: IconButton(
                                visualDensity: VisualDensity(
                                  horizontal: -4.0
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: (){}, icon: SvgPicture.asset(Assets.addCircleIcon)),
                          ),
                          ProductDisplayBoxWidget()
                        ],
                      ),
                    ), separatorBuilder: (context, index)=> 10.pw, itemCount: 5),
                  ),
                  10.ph,
          Text(
            "Order Summary",
            style: context.textStyle.bodyMedium!.copyWith(fontSize: 18.sp),
          ),
          Divider(),
          OrderDetailTitleWidget(
            title: "Item Total",
            value: "\$${product.discountAmount * quantity}",
          ),
          10.ph,
          OrderDetailTitleWidget(
            title: "Total",
            value: "\$${product.discountAmount * quantity}",
          ), 
          10.ph,     
          GestureDetector(
            onTap: (){
              AppRouter.push(VoucherApplyView());},
            child: Row(
              spacing: 10,
              children: [
                SvgPicture.asset(Assets.voucherOutlineIcon),
                Text("Apply Voucher", style: context.textStyle.displayMedium,)
              ],
            ),
          )
          
          ],
        )),
        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: AppTheme.horizontalPadding
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: context.textStyle.displayMedium,),
                  Text("\$160.00", style: context.textStyle.displayMedium!.copyWith(
                    color: AppColors.secondaryColor
                  ),),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 
                  Text("\$160.00", style: context.textStyle.displaySmall!.copyWith(
                    decoration: TextDecoration.lineThrough
                  ),),
                ],)
            ],
          ),
        )
      ],
    ));
  }
}