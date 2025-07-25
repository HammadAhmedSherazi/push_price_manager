import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(context.screenheight * 0.16), child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryAppBarColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r)
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Assets.groceryBag, width: 80.h, height: 80.h,),
            Positioned(
              left: 20.r,
              top: 50.r,
              child: GestureDetector(
                onTap: (){
                  AppRouter.back();
                },
                child: Container(
                width: 25.r,
                height: 25.r,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.r,),
                            ),
              ),)
          ],
        ),
      )),
      body: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
         Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "ABC Product ",
                        style: context.textStyle.displayMedium!.copyWith(
                          fontSize: 16.sp
                        ),
                      ),
                      TextSpan(
                        text: " 20% Off",
                        style: context.textStyle.bodyMedium!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
            10.ph,
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit,  eiusmod tempor Lorem ipsum dolor sit amet, consectetur adipiscing elit,  eiusmod tempor i ", style: context.textStyle.titleSmall,),
            5.ph,
            Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "\$80 ",
                            style: context.textStyle.displayMedium!.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "\$99.99",
                            style: context.textStyle.displayMedium!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Color.fromRGBO(91, 91, 91, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  10.ph,
                  Row(
                    children: [
                      Container(
                          // height: 30.h,
                          padding: EdgeInsets.all(8.r),
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
                                  removeQuantity();
                                },
                                child: SvgPicture.asset(Assets.minusSquareIcon)),
                              Text("$quantity", style: context.textStyle.displayMedium,),
                              GestureDetector(
                                onTap: (){
                                  addQuantity();
                                },
                                child: SvgPicture.asset(Assets.plusSquareIcon)),
                            ],
                          ),
                        ),
                    ],
                  ),
                  20.ph,
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
                  )
                    
        ],
      ),
    );
  }
}