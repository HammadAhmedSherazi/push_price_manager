import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class AddDiscountView extends ConsumerStatefulWidget {
  final bool? isPromotionalDiscount;
  final bool? isInstant;
  final ListingModel data;
  final bool? isLiveListing;
  const AddDiscountView({
    super.key,
    this.isPromotionalDiscount = false,
    this.isInstant = false,
    required this.data,
    this.isLiveListing = false,
  });

  @override
  ConsumerState<AddDiscountView> createState() => _AddDiscountViewState();
}

class _AddDiscountViewState extends ConsumerState<AddDiscountView> {
  late final TextEditingController _currentDiscountEditTextController;
  late final TextEditingController _dialyDiscountEditTextController;
  List<String> titles = [
    'save_discount_for_future_listings',
    'save_duration_with_best_by_date',
    'resume_automatically_next_batch',
  ];

  // List<bool> values = [false, false, true];
  bool setDiscount = false;
  @override
  void initState() {
    Future.microtask(() {
      if (!widget.isLiveListing!) {
        ref
            .read(productProvider.notifier)
            .getSuggestion(
              productId: widget.data.productId,
              storeId: widget.data.storeId,
              item: widget.data,
            );
      } else {
        if(widget.data.saveDiscountForListing){
          ref
            .read(productProvider.notifier)
            .setGoLiveDate(widget.data.goLiveDate);
        }
        
        ref.read(productProvider.notifier).setListItem(widget.data);
      }
    });

    _currentDiscountEditTextController = TextEditingController(
      text:
          widget.data.currentDiscount != 0.0 &&
              widget.data.saveDiscountForFuture
          ? widget.data.currentDiscount.toString()
          : null,
    );
    if (widget.isInstant!) {
      _dialyDiscountEditTextController = TextEditingController(
        text:
            widget.data.hourlyIncreasingDiscountPercent != 0.0 &&
                widget.data.saveDiscountForFuture
            ? widget.data.hourlyIncreasingDiscountPercent.toString()
            : null,
      );
      titles[1] = 'do_not_resume_automatically';
      titles[2] = 'resume_automatically';
      // values[1] = widget.data.dontResumeAutomatically;
      // values[2] = widget.data.resumeAutomatically;
    } else {
      _dialyDiscountEditTextController = TextEditingController(
        text:
            widget.data.dailyIncreasingDiscountPercent != 0.0 &&
                widget.data.saveDiscountForListing
            ? widget.data.dailyIncreasingDiscountPercent.toString()
            : null,
      );
    }

    if (widget.isPromotionalDiscount!) {
      titles = ['Save Discount For Future Listings'];
      // values = [widget.data.saveDiscountForFuture];
    } 

    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (!widget.isLiveListing!) {
      ref.listen(productProvider, (previous, next) {
        final newItem = next.listItem;
        final oldItem = previous!.listItem;
        if (newItem != null && oldItem != null) {
          if (newItem.currentDiscount != oldItem.currentDiscount &&
              newItem.saveDiscountForFuture) {
            _currentDiscountEditTextController.text =
                newItem.currentDiscount != 0.0
                ? newItem.currentDiscount.toStringAsFixed(2)
                : "";
          }
          if (newItem.dailyIncreasingDiscountPercent !=
                  oldItem.dailyIncreasingDiscountPercent &&
              newItem.saveDiscountForFuture) {
            _dialyDiscountEditTextController.text =
                newItem.dailyIncreasingDiscountPercent != 0.0
                ? newItem.dailyIncreasingDiscountPercent.toStringAsFixed(2)
                : "";
          }
          if ((oldItem.goLiveDate == null ||
                  oldItem.goLiveDate != newItem.goLiveDate) &&
              newItem.saveDiscountForListing) {
            ref
                .read(productProvider.notifier)
                .setGoLiveDate(newItem.goLiveDate);
          }
          if (oldItem.autoApplyForNextBatch != newItem.autoApplyForNextBatch) {
            // values[2] = newItem.autoApplyForNextBatch;
          }
          if (oldItem.saveDiscountForFuture != newItem.saveDiscountForFuture) {
            // values[0] = newItem.saveDiscountForFuture;
          }
          if (oldItem.saveDiscountForListing !=
              newItem.saveDiscountForListing) {
            // values[1] = newItem.saveDiscountForListing;
          }
          if (widget.isInstant! &&
              oldItem.hourlyIncreasingDiscountPercent !=
                  newItem.hourlyIncreasingDiscountPercent &&
              newItem.saveDiscountForFuture) {
            _dialyDiscountEditTextController.text =
                newItem.hourlyIncreasingDiscountPercent != 0.0
                ? newItem.hourlyIncreasingDiscountPercent.toStringAsFixed(2)
                : "";
          }
        }
      });
    }

    final data = ref.watch(
      productProvider.select((e) => (e.listItem, e.getSuggestionApiRes)),
    );
    final response = data.$2;
    final item = data.$1;

    return Material(
      child: AsyncStateHandler(
        status: widget.isLiveListing! ? Status.completed : response.status,
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

          customBottomWidget: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: CustomButtonWidget(
              title: widget.isLiveListing!
                  ? context.tr(widget.isInstant! ? "next" : "update")
                  : context.tr(widget.isInstant! ? "next" : "list_now"),
              isLoad: widget.isLiveListing! && !widget.isInstant!
                  ? ref
                            .watch(
                              productProvider.select((e) => e.updateApiRes),
                            )
                            .status ==
                        Status.loading
                  : ref
                            .watch(
                              productProvider.select((e) => e.setReviewApiRes),
                            )
                            .status ==
                        Status.loading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> data = {};
                  if (widget.isLiveListing!) {
                    final route = ModalRoute.of(context);
                    final args = route?.settings.arguments;
                    if (args is Map<String, dynamic>) {
                      data = Map<String, dynamic>.from(args);
                    }
                  }
                  if (widget.isPromotionalDiscount!) {
                    data.addAll({
                      "save_discount_for_future": item!.saveDiscountForFuture,
                      "go_live_date": item.goLiveDate!.toIso8601String(),
                      "listing_id": item.listingId,
                      "current_discount": double.parse(
                        _currentDiscountEditTextController.text,
                      ),
                     
                    });
                  } else {
                    data.addAll({
                      "save_discount_for_future": item!.saveDiscountForFuture,
                      "save_duration_for_listing": item.saveDiscountForListing,
                      "auto_apply_for_next_batch": item.autoApplyForNextBatch,
                      "go_live_date": item.goLiveDate!.toIso8601String(),
                      "listing_id": item.listingId,
                      "current_discount": double.parse(
                        _currentDiscountEditTextController.text,
                      ),
                      "daily_increasing_discount_percent": double.parse(
                        _dialyDiscountEditTextController.text,
                      ),
                    });
                  }
                  if (widget.isInstant!) {
                    data['hourly_increasing_discount'] = double.parse(
                      _dialyDiscountEditTextController.text,
                    );
                    data['dont_resume_automatically'] =
                        item.dontResumeAutomatically;
                    data['resume_automatically'] = item.resumeAutomatically;
                    data.remove("daily_increasing_discount_percent");
                    data.remove("save_duration_for_listing");
                    data.remove("auto_apply_for_next_batch");
                    AppRouter.push(
                      ListScheduleCalenderView(
                        isLiveListing: widget.isLiveListing!,
                        data: data,
                        listData: item,
                      ),
                    );
                  } else {
                    if (widget.isLiveListing!) {
                      ref
                          .read(productProvider.notifier)
                          .updateList(
                            listingId: item.listingId,
                            input: data,
                            times: 3,
                          );
                    } else {
                      ref
                          .read(productProvider.notifier)
                          .setReview(input: data, times: 3);
                    }
                  }
                }
              },
            ),
          ),

          title: context.tr("add_discount"),
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
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  validator: (value) => value?.validateCurrentDiscount(),
                  decoration: InputDecoration(
                    hintText: context.tr("current_discount"),
                    suffixIcon: Icon(
                      Icons.percent_sharp,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                if (!widget.isPromotionalDiscount!) ...[
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
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    validator: (value) => value?.validateCurrentDiscount(),
                    decoration: InputDecoration(
                      hintText: widget.isInstant!
                          ? context.tr("hourly_increasing_discount")
                          : context.tr("daily_increasing_discount"),
                      suffixIcon: Icon(
                        Icons.percent_sharp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],

                10.ph,
                CustomDateSelectWidget(
                  label: "label",
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ), // ✅ set a valid future limit
                  validator: (value) => value?.validateDate(),
                  hintText: context.tr('listing_start_date'),
                  onDateSelected: (date) {
                    // ✅ Safe state update after build
                    ref.read(productProvider.notifier).setGoLiveDate(date);
                  },
                  selectedDate: item!.goLiveDate,
                ),
                20.ph,

                ...List.generate(
                  titles.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          context.tr(titles[index]),
                          style: context.textStyle.bodyMedium,
                        ),
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        side: BorderSide(color: AppColors.secondaryColor),
                        value: index == 0
                            ? item.saveDiscountForFuture
                            : index == 1
                            ? widget.isInstant!
                                  ? item.dontResumeAutomatically
                                  : item.saveDiscountForListing
                            : widget.isInstant!
                            ? item.resumeAutomatically
                            : item.autoApplyForNextBatch,
                        onChanged: (v) {
                          if ((item.autoApplyForNextBatch ||
                                  (widget.isInstant! &&
                                      item.resumeAutomatically)) &&
                              index != 2) {
                            return;
                          }
                              ref
                                .read(productProvider.notifier)
                                .setCheckBox(v!, index, widget.isInstant!);
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
