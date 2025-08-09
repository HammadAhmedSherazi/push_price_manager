import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductView extends StatefulWidget {
  final String type;
  final int popTime;
  const ListingProductView({super.key, required this.type, required this.popTime});

  @override
  State<ListingProductView> createState() => _ListingProductViewState();
}

class _ListingProductViewState extends State<ListingProductView> {
  // int quantity = 1;
  // addQuantity(){
   
  //   setState(() {
  //      quantity++;
  //   });
  // }
  // removeQuantity(){
  //   if(quantity > 1){
  //     setState(() {
  //       quantity--;
  //   });
  //   }
    
  // }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "list now",
      onButtonTap: (){
        AppRouter.customback(times: widget.popTime);
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
              onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
            decoration: InputDecoration(
              hintText: "Best By Date"
            ),
          ),
          ],
          if(widget.type == "Best By Products")...[
             TextFormField(
              onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
            decoration: InputDecoration(
              hintText: "Product Name (Pre-filled)"
            ),
          ),
          ],
          TextFormField(
            onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
            decoration: InputDecoration(
              hintText: "Quantity"
            ),
          ),
          Text("Product Qunatity", style: context.textStyle.bodyMedium,),
          QuantitySelector(),     
          if(widget.type == "Weighted Items")...[
                     TextFormField(
                      onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
            decoration: InputDecoration(
              hintText: "Price 1"
            ),
          ),
            TextFormField(
              onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
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


