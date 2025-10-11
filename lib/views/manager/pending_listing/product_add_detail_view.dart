import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ProductAddDetailView extends StatefulWidget {
  final String title;
  final String type;
  final ListingModel data;
  const ProductAddDetailView({
    super.key,
    required this.title,
    required this.type,
    required this.data,
  });

  @override
  State<ProductAddDetailView> createState() => _ProductAddDetailViewState();
}

class _ProductAddDetailViewState extends State<ProductAddDetailView> {
  late final TextEditingController productTitleController;
  late final TextEditingController productDescriptionController;
  late final TextEditingController productPriceController;
  late final TextEditingController productCategoryTitleController;
  late final TextEditingController productBestDateController;
  late final TextEditingController storeTitleController;
  final List<String> types = [
    "Best By Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products",
  ];
  String selectType = "";
  DateTime? bestByDate;
  // int quantity = 1;
  //   addQuantity(){

  //     setState(() {
  //        quantity++;
  //     });
  //   }
  //   removeQuantity(){
  //     if(quantity > 1){
  //       setState(() {
  //         quantity--;
  //     });
  //     }

  //   }

  @override
  void initState() {
    selectType = widget.type;
    productTitleController = TextEditingController(
      text: widget.data.product!.title,
    );
    productDescriptionController = TextEditingController(
      text: widget.data.product!.description,
    );
    productPriceController = TextEditingController(
      text: widget.data.product!.price!.toStringAsFixed(2),
    );
    storeTitleController = TextEditingController(
      text: widget.data.store.storeName,
    );
    productCategoryTitleController = TextEditingController(
      text: widget.data.product?.category?.title,
    );
    quantity = widget.data.quantity;
    bestByDate = widget.data.bestByDate;
    if (selectType == "Weighted Items") {
      priceControllers = List.generate(
        widget.data.weightedItemsPrices!.length,
        (index) => TextEditingController(
          text: widget.data.weightedItemsPrices![index].toStringAsFixed(2),
        ),
      );
    }
    super.initState();
  }

  List<TextEditingController?> priceControllers = [];
  int quantity = 0;

  void changeQuantity(int value) {
    if (value <= 0) {
      if (priceControllers.isNotEmpty) {
        setState(() {
          quantity = value;
          priceControllers.clear();
        });
      }

      return;
    } // Prevent invalid quantity

    setState(() {
      if (selectType == "Weighted Items") {
        if (value > quantity) {
          // Add controllers for the extra values
          priceControllers.addAll(
            List.generate(value - quantity, (_) => TextEditingController()),
          );
        } else if (value < quantity) {
          // Remove extra controllers safely
          priceControllers.removeRange(value, priceControllers.length);
        }
      }
      quantity = value; // Update the current quantity
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      customBottomWidget: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppTheme.horizontalPadding,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            return CustomButtonWidget(
              isLoad:
                  ref.watch(productProvider).updateApiRes.status ==
                  Status.loading,
              title: "update",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> data = {
                    "listing_type": Helper.setType(selectType),
                    "quantity" : quantity
                  };
                  if (selectType == types[0] || selectType == types[2]) {
                    if (bestByDate == null) {
                      Helper.showMessage(
                        context,
                        message: "Please select a date",
                      );
                      return;
                    }
                    data["best_by_date"] = bestByDate!.toIso8601String();
                  }
                  if (selectType == types[2]) {
                    data['weighted_items_prices'] = List.generate(
                      priceControllers.length,
                      (index) => num.parse(priceControllers[index]!.text),
                    );
                  }
                ref.read(productProvider.notifier).updateList(listingId: widget.data.listingId, input: data);

                }

              },
            );
          },
        ),
      ),

      title: widget.title,
      child: Form(
        key: _formKey,
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
                  DisplayNetworkImage(
                    imageUrl: widget.data.product!.image,
                    width: 60.r,
                    height: 60.r,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 15.r,
                horizontal: AppTheme.horizontalPadding,
              ),
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    controller: productTitleController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Name (Pre-filled)",
                    ),
                    readOnly: true,
                  ),
                  TextFormField(
                    controller: storeTitleController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Store Name (Pre-filled)",
                    ),
                    readOnly: true,
                  ),
                  TextFormField(
                    controller: productDescriptionController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    readOnly: true,
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Product Details (Pre-filled)",
                    ),
                  ),
                  TextFormField(
                    controller: productCategoryTitleController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Category (Pre-filled)",
                    ),
                    readOnly: true,
                  ),
                  TextFormField(
                    controller: productPriceController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Price (Pre-filled)",
                    ),
                    readOnly: true,
                  ),
                  CustomDropDown(
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectType = value;
                          if (selectType == types[2] &&
                              priceControllers.length != quantity) {
                            if (priceControllers.isNotEmpty) {
                              priceControllers.clear();
                            }

                            priceControllers.addAll(
                              List.generate(
                                quantity,
                                (_) => TextEditingController(),
                              ),
                            );
                          }
                        });
                      }
                    },
                    placeholderText: selectType,
                    options: types.map((type) {
                      return CustomDropDownOption(
                        value: type,
                        displayOption: type,
                      );
                    }).toList(),
                  ),
                  if (selectType == types[0] || selectType == types[2])
                    CustomDateSelectWidget(
                      label: "Date",
                      selectedDate: bestByDate,
                      hintText: "Select a Best Date",
                      onDateSelected: (date) {
                        setState(() {
                          bestByDate = date;
                        });
                      },
                    ),
                  Row(
                    children: [
                      Text(
                        "Product Quantity",
                        style: context.textStyle.displayMedium,
                      ),
                    ],
                  ),
                  // Row(
                  //     spacing: 10,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           removeQuantity();
                  //         },
                  //         child: SvgPicture.asset(Assets.minusSquareIcon, width: 25.r, height: 25.r,),
                  //       ),
                  //       Container(
                  //         height: 24.h,
                  //         alignment: Alignment.center,
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: 20.r
                  //         ),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: AppColors.borderColor
                  //           ),
                  //           borderRadius: BorderRadius.horizontal(
                  //             left: Radius.circular(5.r),
                  //             right: Radius.circular(5  .r)
                  //           )
                  //         ),
                  //         child: Text("$quantity", style: context.textStyle.displayMedium)),
                  //       GestureDetector(
                  //         onTap: () {
                  //           addQuantity();
                  //         },
                  //         child: SvgPicture.asset(Assets.plusSquareIcon, width: 25.r,),
                  //       ),
                  //     ],
                  //   ),
                  QuantitySelector(
                    initialQuantity: quantity,
                    onQuantityChanged: changeQuantity,
                  ),
                  if (selectType == types[2] && quantity > 0) ...[
                    ...List.generate(
                      priceControllers.length,
                      (index) => TextFormField(
                        controller: priceControllers[index],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null) {
                            return "Required";
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Price ${index + 1}",
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
