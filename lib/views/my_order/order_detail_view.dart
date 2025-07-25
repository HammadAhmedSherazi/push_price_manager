import 'package:push_price_manager/utils/extension.dart';


import '../../export_all.dart';

class OrderDetailView extends StatefulWidget {
  final OrderStatus orderStatus;
  final bool? afterPayment;
  const OrderDetailView({super.key, required this.orderStatus, this.afterPayment = false});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  void showReasonDialog(BuildContext context) {
  int selectedIndex = 0;
  List<String> reasons = [
    "Product not available",
    "Lorem ipsum dolor sit amet consectetur.",
    "Lorem ipsum dolor sit amet consectetur.",
  ];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder( // To manage state in dialog
        builder: (context, setState) {
          return Dialog(
            backgroundColor: const Color(0xFFF1F6FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
                vertical: 25.r
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Reason",
                    style: context.textStyle.bodyMedium!.copyWith(
                      fontSize: 18.sp
                    ),
                  ),
                  20.ph,

                  // Radio List
                  ...List.generate(reasons.length, (index) {
                    return Column(
                      children: [
                        RadioListTile<int>(
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: (value) {
                            setState(() => selectedIndex = value!);
                          },
                          title: Text(reasons[index], style: context.textStyle.displayMedium,),
                          activeColor: AppColors.secondaryColor,
                          contentPadding: EdgeInsets.zero,
                        ),
                        if (index != reasons.length - 1)
                          Divider(height: 1,),
                      ],
                    );
                  }),

                  20.ph,

                  // Next Button
                  CustomButtonWidget(title: "next", onPressed: (){
                    AppRouter.back();
                  })
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      title: "Order details",
      bottomButtonText:  widget.afterPayment!?"back to home" : null,
      onButtonTap: (){
        AppRouter.customback(times: 6);
      },
      showBottomButton: widget.orderStatus == OrderStatus.inProcess || widget.afterPayment!,
      customBottomWidget: widget.orderStatus == OrderStatus.inProcess? 
      Padding(padding: EdgeInsets.all(AppTheme.horizontalPadding), child: Column(
        spacing: 15,
        children: [
          CustomOutlineButtonWidget(title: "modify order", onPressed: (){
            AppRouter.push(ModifyOrderView());
          }),
          CustomButtonWidget(title: "make payment", onPressed: (){
            AppRouter.push(SelectPaymentMethodView());
          }),
        ],
      ),) : null,
      actionWidget: widget.orderStatus == OrderStatus.inProcess
          ? Row(
              children: [
                TextButton(
                  onPressed: () {
                    showReasonDialog(context);
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity(
                      horizontal: -4.0,
                      vertical: -4.0,
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: Text(
                    "Cancel Order",
                    style: context.textStyle.displayMedium!.copyWith(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                20.pw,
              ],
            )
          : null,
      child: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
          Text(
            "Order Details",
            style: context.textStyle.bodyMedium!.copyWith(fontSize: 18.sp),
          ),
          10.ph,
          OrderItemCardWidget(),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                setTitle(widget.orderStatus),
                style: context.textStyle.bodyMedium!.copyWith(fontSize: 18.sp),
              ),
              Text("Today 3:45pm", style: context.textStyle.bodySmall,)
            ],
          ),
          Divider(),
          OrderDetailTitleWidget(
            title: "Order ID",
            value: "#652327" ,
          ),
          10.ph,
          OrderDetailTitleWidget(
            title: "Date",
            value: "April 2, 2025" ,
          ),
          10.ph,
          OrderDetailTitleWidget(
            title: "Total",
            value: "\$80.00" ,
          ),
          if(widget.orderStatus == OrderStatus.completed)...[
            30.verticalSpace,
          Center(
            child: Column(
              spacing: 10,
              children: [
                SvgPicture.asset(Assets.checkCircleIcon, width: 60.r,),
                Container(
                  width: 75.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor
                  ),
                  child: Text("PAID", style: context.textStyle.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp
                  ),),
                )
              ],
            ),
          )
          ]
          
        ],
      ),
    );
  }
}

setTitle(OrderStatus status){
  switch (status) {
    case OrderStatus.inProcess:
      return "Order In-Process";
    case OrderStatus.completed:
      return "Order Completed";
    case OrderStatus.cancelled:
      return "Order Cancelled";   
      
   
  }
}

class OrderDetailTitleWidget extends StatelessWidget {
  final String title;
  final String value;
  const OrderDetailTitleWidget({
    super.key,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: context.textStyle.bodyMedium!.copyWith(
              color: Color.fromRGBO(91, 91, 91, 1)
            ),),
            Text(value, style: context.textStyle.displayMedium,)
          ],
        ),
    //     SizedBox(
    //   width: double.infinity,
    //   height: 1,
    //   child: CustomPaint(
    //     painter: DottedLinePainter(),
    //   ),
    // ),
      ],
    );
  }
}

class OrderItemCardWidget extends StatelessWidget {
  const OrderItemCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 3.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color.fromRGBO(243, 243, 243, 1),
      ),
      child: Row(
        spacing: 10,
        children: [
          Image.asset(Assets.groceryBag, width: 50.w, height: 70.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "ABC Product ",
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
                3.ph,
                Text(
                  "Best By: April 25, 2025",
                  style: context.textStyle.bodySmall!.copyWith(
                    color: AppColors.primaryTextColor.withValues(alpha: 0.7),
                  ),
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quantity: 01",
                      style: context.textStyle.displayMedium!.copyWith(
                        color: Color.fromRGBO(91, 91, 91, 1),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.end,
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
                  ],
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
