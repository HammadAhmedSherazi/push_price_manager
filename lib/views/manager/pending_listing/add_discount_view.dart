import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class AddDiscountView extends ConsumerStatefulWidget {
  final bool? isPromotionalDiscount;
  final bool? isInstant;
  final ListingModel data;
  const AddDiscountView({
    super.key,
    this.isPromotionalDiscount = false,
    this.isInstant = false,
    required this.data,
  });

  @override
  ConsumerState<AddDiscountView> createState() => _AddDiscountViewState();
}

class _AddDiscountViewState extends ConsumerState<AddDiscountView> {
  late final TextEditingController _currentDiscountEditTextController;
  late final TextEditingController _dialyDiscountEditTextController;
  List<String> titles = [
    'Save Discount For Future Listings',
    'Save Duration of Listing Start Date in Accordance with the Best By Date for future Listings',
    'Resume Automatically For The Next Batch',
  ];

  List<bool> values = [false, false, true];
  bool setDiscount = false;
  @override
  void initState() {
    Future.microtask(() {
      ref
          .read(productProvider.notifier)
          .getSuggestion(
            productId: widget.data.productId,
            storeId: widget.data.storeId,
            item: widget.data,
          );
     
    });
    _currentDiscountEditTextController = TextEditingController(
    
    );
    _dialyDiscountEditTextController = TextEditingController(
     
    );

    if (widget.isPromotionalDiscount!) {
      titles = ['Save Discount For Future Listings'];
      values = [false];
    } else {
      values = [
        widget.data.saveDiscountForFuture,
        widget.data.saveDiscountForListing,
        widget.data.autoApplyForNextBatch,
      ];
    }

    super.initState();
  }
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if(!setDiscount){
    ref.listen(productProvider, (previous, next) {
    final newItem = next.listItem;
    if (newItem != null) {
      _currentDiscountEditTextController.text = newItem.currentDiscount != 0.0?
          newItem.currentDiscount.toStringAsFixed(2) : "";
      _dialyDiscountEditTextController.text = newItem.dailyIncreasingDiscountPercent != 0.0 ?
          newItem.dailyIncreasingDiscountPercent.toStringAsFixed(2) : "";
          setDiscount = true;
      ref.read(productProvider.notifier).setGoLiveDate(newItem.goLiveDate);
    }
  });
  }
    final providerVM = ref.watch(productProvider);
    final listItem = providerVM.listItem ?? widget.data;

    return Material(
      child: AsyncStateHandler(
        status: providerVM.getSuggestionApiRes.status,
        dataList: [0],
        itemBuilder: null,
        onRetry: () {
          ref
              .read(productProvider.notifier)
              .getSuggestion(
                productId: widget.data.productId,
                storeId: widget.data.storeId,
                item: widget.data,
              );
        },
        customSuccessWidget: CustomScreenTemplate(
          showBottomButton: true,
          bottomButtonText: "next",
          customBottomWidget: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: CustomButtonWidget(
              title: "next",
              isLoad: widget.isInstant!
                  ? providerVM.getSuggestionApiRes.status == Status.loading
                  : false,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> data = {};
                    if (widget.isPromotionalDiscount!) {
                      data = {
                        "save_discount_for_future":
                            listItem.saveDiscountForFuture,
                        "go_live_date":  listItem.goLiveDate!.toIso8601String(),
                        "listing_id": listItem.listingId,
                        "current_discount": double.parse(_currentDiscountEditTextController.text),
                        "daily_increasing_discount_percent": double.parse(_dialyDiscountEditTextController.text),
                      };
                    } else {
                      data = {
                        "save_discount_for_future":
                            listItem.saveDiscountForFuture,
                        "save_duration_for_listing":
                            listItem.saveDiscountForListing,
                        "auto_apply_for_next_batch":
                            listItem.autoApplyForNextBatch,
                        "go_live_date": listItem.goLiveDate!.toIso8601String(),
                        "listing_id": listItem.listingId,
                        "current_discount": double.parse(_currentDiscountEditTextController.text),
                        "daily_increasing_discount_percent": double.parse(_dialyDiscountEditTextController.text),
                      };
                    }
                  if (widget.isInstant!) {
                    data['hourly_increasing_discount'] = double.parse(_dialyDiscountEditTextController.text);
                    data.remove("daily_increasing_discount_percent");
                    AppRouter.push(ListScheduleCalenderView(

                      data: data,

                    ));
                  } else {
                    
                    ref
                        .read(productProvider.notifier)
                        .setReview(input: data, times:  3);
                  }
                }
              },
            ),
          ),
      
          title: "Add Discount",
          child: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(AppTheme.horizontalPadding),
              children: [
                TextFormField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  controller: _currentDiscountEditTextController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  validator: (value) => value?.validateCurrentDiscount(),
                  decoration: InputDecoration(
                    hintText: "Current Discount",
                    suffixIcon: Icon(
                      Icons.percent_sharp,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                10.ph,
                TextFormField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  controller: _dialyDiscountEditTextController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  validator: (value) => value?.validateCurrentDiscount(),
                  decoration: InputDecoration(
                    hintText: widget.isInstant!?"Hourly Increasing Discoun" :  "Daily Increasing Discount",
                    suffixIcon: Icon(
                      Icons.percent_sharp,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                10.ph,
                CustomDateSelectWidget(
                  label: "label",
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ), // ✅ set a valid future limit
                  validator: (value) => value?.validateDate(),
                  hintText: "Listing Start Date",
                  onDateSelected: (date) {
                    // ✅ Safe state update after build
                    ref.read(productProvider.notifier).setGoLiveDate(date);
                  },
                  selectedDate: null,
                ),
                20.ph,
      
                ...List.generate(
                  titles.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          titles[index],
                          style: context.textStyle.bodyMedium,
                        ),
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        side: BorderSide(color: AppColors.secondaryColor),
                        value: index == 0
                            ? listItem.saveDiscountForFuture
                            : index == 1
                            ? listItem.saveDiscountForListing
                            : listItem.autoApplyForNextBatch,
                        onChanged: (v) {
                          ref
                              .read(productProvider.notifier)
                              .setCheckBox(v!, index);
                        },
                        activeColor: AppColors.secondaryColor,
                      ),
      
                      // Radio<int>(
                      //   value: index,
                      //   groupValue: selectedIndex,
                      //   onChanged: (val) {
                      //     setState(() {
                      //       selectedIndex = val!;
                      //     });
                      //   },
                      //   fillColor: MaterialStateProperty.resolveWith((_) => AppColors.secondaryColor),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define the enum or value type used to track selection


// In your widget state:


// Example inside your widget build method:
