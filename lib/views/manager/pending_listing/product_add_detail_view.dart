import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ProductAddDetailView extends StatefulWidget {
  final String title;
  final String type;
  final ListingModel data;
  final bool? isLiveListing;
  const ProductAddDetailView({
    super.key,
    required this.title,
    required this.type,
    required this.data,
    this.isLiveListing = false,
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
    "best_by_products",
    "instant_sales",
    "weighted_items",
    "promotional_products",
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
              title: widget.isLiveListing! ? context.tr("next") : context.tr("update"),
              onPressed: () {
                // Manual validation for price controllers before form validation
                if (selectType ==
                        Helper.getTypeTitle(Helper.setType(types[2])) &&
                    quantity > 0) {
                  // Check if we have the right number of controllers
                  if (priceControllers.length != quantity) {
                    Helper.showMessage(
                      context,
                      message: context.tr('please_set_the_quantity_first'),
                    );
                    return;
                  }

                  // Validate each price controller
                  for (int i = 0; i < priceControllers.length; i++) {
                    final priceText = priceControllers[i]!.text;
                    if (priceText.isEmpty) {
                      Helper.showMessage(
                        context,
                        message: "${context.tr('price')} ${i + 1} ${context.tr('is_required')}",
                      );
                      return;
                    }
                    if (double.tryParse(priceText) == null) {
                      Helper.showMessage(
                        context,
                        message: "${context.tr('price')} ${i + 1} ${context.tr('must_be_a_valid_number')}",
                      );
                      return;
                    }
                    if (double.parse(priceText) <= 0) {
                      Helper.showMessage(
                        context,
                        message: "${context.tr('price')} ${i + 1} ${context.tr('must_be_greater_than_0')}",
                      );
                      return;
                    }
                  }
                }

                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> data = {
                    "listing_type": Helper.setType(selectType),
                    "quantity": quantity,
                  };
                  if (selectType ==
                          Helper.getTypeTitle(Helper.setType(types[0])) ||
                      selectType ==
                          Helper.getTypeTitle(Helper.setType(types[2]))) {
                    if (bestByDate == null) {
                      Helper.showMessage(
                        context,
                        message: context.tr("please_select_a_date"),
                      );
                      return;
                    }
                    data["best_by_date"] = bestByDate!.toIso8601String();
                  }
                  if (selectType ==
                      Helper.getTypeTitle(Helper.setType(types[2]))) {
                    data['weighted_items_prices'] = List.generate(
                      priceControllers.length,
                      (index) => num.parse(priceControllers[index]!.text),
                    );
                  }
                  if (widget.isLiveListing!) {
                    ref.read(productProvider.notifier).setListItem(widget.data);
                    AppRouter.push(
                      AddDiscountView(
                        data: widget.data,
                        isLiveListing: widget.isLiveListing,
                        isInstant:
                            selectType ==
                            Helper.getTypeTitle(Helper.setType(types[1])),
                        isPromotionalDiscount:
                            selectType ==
                            Helper.getTypeTitle(Helper.setType(types[3])),
                      ),
                      settings: RouteSettings(arguments: data),
                    );
                  } else {
                    ref
                        .read(productProvider.notifier)
                        .updateList(
                          listingId: widget.data.listingId,
                          input: data,
                        );
                  }
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
                  if(widget.data.initiatorType == "EMPLOYEE")
                  CustomDropDown(
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectType = value;
                          if (selectType ==
                              Helper.getTypeTitle(Helper.setType(types[2]))) {
                            // Clear existing controllers
                            if (priceControllers.isNotEmpty) {
                              priceControllers.clear();
                            }
                            // Initialize controllers based on current quantity
                            if (quantity > 0) {
                              priceControllers.addAll(
                                List.generate(
                                  quantity,
                                  (_) => TextEditingController(),
                                ),
                              );
                            }
                          } else {
                            // Clear controllers when switching away from Weighted Items
                            if (priceControllers.isNotEmpty) {
                              priceControllers.clear();
                            }
                          }
                        });
                      }
                    },
                    placeholderText: selectType,
                    options: types.map((type) {
                      return CustomDropDownOption(
                        value: Helper.getTypeTitle(Helper.setType(type)),
                        displayOption: Helper.getTypeTitle(
                          Helper.setType(type),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  if(widget.data.initiatorType == "MANAGER")
                   TextFormField(
                    controller: TextEditingController(text: selectType),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Price (Pre-filled)",
                    ),
                    readOnly: true,
                  ),
                  if (selectType ==
                          Helper.getTypeTitle(Helper.setType(types[0])) ||
                      selectType ==
                          Helper.getTypeTitle(Helper.setType(types[2])))
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
                        context.tr("product_quantity"),
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
                  if (selectType ==
                          Helper.getTypeTitle(Helper.setType(types[2])) &&
                      quantity > 0) ...[
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
                          if (value == null || value.isEmpty) {
                            return "Price is required";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid price";
                          }
                          if (double.parse(value) <= 0) {
                            return "Price must be greater than 0";
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
