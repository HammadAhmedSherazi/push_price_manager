import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductView extends StatefulWidget {
  final String type;
  const ListingProductView({super.key, required this.type});

  @override
  State<ListingProductView> createState() => _ListingProductViewState();
}

class _ListingProductViewState extends State<ListingProductView> {
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
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "list now",
      onButtonTap: (){
        AppRouter.customback(times: 2);
        AppRouter.push(SuccessListingRequestView(message: "Product Listing Successful!"));
      },
      title: "List Product", child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        
        children: [
          if(widget.type == "Weighted Items")...[
             TextFormField(
            decoration: InputDecoration(
              hintText: "Best By Date"
            ),
          ),
          ],
          if(widget.type == "Best By Products")...[
             TextFormField(
            decoration: InputDecoration(
              hintText: "Product Name (Pre-filled)"
            ),
          ),
          ],
          TextFormField(
            decoration: InputDecoration(
              hintText: "Quantity"
            ),
          ),
          Text("Product Qunatity", style: context.textStyle.bodyMedium,),
           Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeQuantity();
                        },
                        child: SvgPicture.asset(Assets.minusSquareIcon, width: 25.r, height: 25.r,),
                      ),
                      Container(
                        height: 24.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.r
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.borderColor
                          ),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(5.r),
                            right: Radius.circular(5  .r)
                          )
                        ),
                        child: Text("$quantity", style: context.textStyle.displayMedium)),
                      GestureDetector(
                        onTap: () {
                          addQuantity();
                        },
                        child: SvgPicture.asset(Assets.plusSquareIcon, width: 25.r,),
                      ),
                    ],
                  ),
                  if(widget.type == "Weighted Items")...[
                     TextFormField(
            decoration: InputDecoration(
              hintText: "Price 1"
            ),
          ),
            TextFormField(
            decoration: InputDecoration(
              hintText: "Price 2"
            ),
          ),
                  ]
              
        ],
      ),
    ));
  }
}