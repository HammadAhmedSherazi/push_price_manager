import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingProductView extends StatefulWidget {
  final String type;
  final int popTime;
  const ListingProductView({
    super.key,
    required this.type,
    required this.popTime,
  });

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
  TextEditingController? dateTextController;
  List<TextEditingController?> priceControllers = [];
  int quantity = 0;

void changeQuantity(int value) {
  if (value <= 0) return; // Prevent invalid quantity

  setState(() {
    if (value > quantity) {
      // Add controllers for the extra values
      priceControllers.addAll(
        List.generate(value - quantity, (_) => TextEditingController()),
      );
    } else if (value < quantity) {
      // Remove extra controllers safely
      priceControllers.removeRange(value, priceControllers.length);
    }

    quantity = value; // Update the current quantity
  });
}
  @override
  void initState() {
    dateTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "list now",
      onButtonTap: () {
        if(quantity == 0){
          Helper.showMessage(context, message: "Please add quantity of product");
        }
        else{
          AppRouter.customback(times: widget.popTime);
        AppRouter.push(
          SuccessListingRequestView(message: "Product Listing Successful!"),
        );
        }
        
      },
      title: "List Product",
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        child: quantity > 4
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,

                  children: [
                    // SizedBox(height: context.screenheight * 0.26,),
                    if (widget.type == "Weighted Items" ||
                        widget.type == "Best By Products") ...[
                      TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: dateTextController,
                        decoration: InputDecoration(hintText: "Best By Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime now = DateTime.now();
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            String formattedDate = Helper.selectDateFormat(
                              pickedDate,
                            );
                            setState(() {
                              dateTextController!.text = formattedDate;
                            });
                          }
                        },
                      ),
                    ],
                    if (widget.type == "Best By Products") ...[
                      TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Product Name (Pre-filled)",
                        ),
                      ),
                    ],
                    //           TextFormField(
                    //             onTapOutside: (event) {
                    //   FocusScope.of(context).unfocus();
                    // },
                    //             decoration: InputDecoration(
                    //               hintText: "Quantity"
                    //             ),
                    //           ),
                    Text(
                      "Product Quantity",
                      style: context.textStyle.bodyMedium,
                    ),
                    QuantitySelector(
                      onQuantityChanged: changeQuantity,
                      initialQuantity: quantity,
                    ),
                    if (widget.type == "Weighted Items" && quantity > 0) ...[
                      ...List.generate(
                        priceControllers.length,
                        (index) => TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: "Price ${index + 1}",
                          ),
                        ),
                      ),
                      //       TextFormField(
                      //         onTapOutside: (event) {
                      //   FocusScope.of(context).unfocus();
                      // },
                      //       decoration: InputDecoration(
                      //         hintText: "Price 2"
                      //       ),
                      //     ),
                    ],
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,

                children: [
                  // SizedBox(height: context.screenheight * 0.26,),
                  if (widget.type == "Weighted Items" ||
                      widget.type == "Best By Products") ...[
                    TextFormField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: dateTextController,
                      decoration: InputDecoration(hintText: "Best By Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime now = DateTime.now();
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          String formattedDate = Helper.selectDateFormat(
                            pickedDate,
                          );
                          setState(() {
                            dateTextController!.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ],
                  if (widget.type == "Best By Products") ...[
                    // TextFormField(
                    //   onTapOutside: (event) {
                    //     FocusScope.of(context).unfocus();
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: "Product Name (Pre-filled)",
                    //   ),
                    // ),
                  ],
                  //           TextFormField(
                  //             onTapOutside: (event) {
                  //   FocusScope.of(context).unfocus();
                  // },
                  //             decoration: InputDecoration(
                  //               hintText: "Quantity"
                  //             ),
                  //           ),
                  Text("Product Quantity", style: context.textStyle.bodyMedium),
                  QuantitySelector(
                    onQuantityChanged: changeQuantity,
                    initialQuantity: quantity,
                  ),
                  if (widget.type == "Weighted Items" && quantity > 0) ...[
                    ...List.generate(
                      priceControllers.length,
                      (index) => TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Price ${index + 1}",
                        ),
                      ),
                    ),
                    //       TextFormField(
                    //         onTapOutside: (event) {
                    //   FocusScope.of(context).unfocus();
                    // },
                    //       decoration: InputDecoration(
                    //         hintText: "Price 2"
                    //       ),
                    //     ),
                  ],
                ],
              ),
      ),
    );
  }
}
