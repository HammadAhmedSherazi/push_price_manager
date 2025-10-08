import 'package:push_price_manager/utils/extension.dart';
import '../../../export_all.dart';

class ProductLiveListingDetailView extends StatelessWidget {

  final String type;
  // final ProductDataModel data;
  const ProductLiveListingDetailView({super.key, required this.type, });

  @override
  Widget build(BuildContext context) {
 List<InfoDataModel> getInfoList(String selectedType) {
  if (type ==  "Best By Products") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: Helper.selectDateFormat(DateTime.now())),
      InfoDataModel(title: "Product Quantity", description: "50"),
      InfoDataModel(title: "Current Discount", description: "30%"),
      InfoDataModel(title: "Daily Increasing Discount", description: "5%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now())),
    ];
  } else if (type == "Instant Sales") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "50"),
      InfoDataModel(title: "Current Discount", description: "30%"),
      InfoDataModel(title: "Hourly Increasing Discount", description: "5%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now())), 
    ];
  } else if (selectedType == "Weighted Items") {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Best By Date", description: Helper.selectDateFormat(DateTime.now())),
      InfoDataModel(title: "Product Quantity", description: "50"),
      InfoDataModel(title: "Price 1", description: "\$199.99"),
      InfoDataModel(title: "Price 2", description: "\$199.99"),
      InfoDataModel(title: "Average Price", description: "\$199.99"),
      InfoDataModel(title: "Current Discount", description: "30%"),
     ];
  } else {
    return [
      InfoDataModel(title: "Listing Type", description: selectedType),
      InfoDataModel(title: "Product Quantity", description: "50"),
      InfoDataModel(title: "Discount", description: "30%"),
      InfoDataModel(title: "Listing Start Date", description: Helper.selectDateFormat(DateTime.now())), 
    ];
  }
}

 
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "",
      onButtonTap: (){
        
      },
      customBottomWidget: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: AppTheme.horizontalPadding 
        ),
        child: Column(
          spacing: 10,
          children: [
            if(type == "Promotional Products")
            CustomButtonWidget(title: "Pause", onPressed: (){}),
            
              
        
              CustomOutlineButtonWidget(title: "edit", onPressed: (){
                // AppRouter.push(ProductAddDetailView(title: "Product Listings - List Product", type: type,));
              }),
              CustomButtonWidget(title: "delete", onPressed: (){}, color: Color(0xffB80303),)
           
          ],
        ),
      ),
      title: "Product Listings - List Product",
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: AppTheme.horizontalPadding),
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            height: context.screenheight * 0.18,
            color: AppColors.primaryAppBarColor,
            child: Image.asset(Assets.groceryBag),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 10.r,
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ABC Product",
                      style: context.textStyle.displayMedium!.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text("Today 3:45pm", style: context.textStyle.bodySmall),
                  ],
                ),
                10.ph,
                ProductTitleWidget(title: "Category", value: "ABC Category"),
                ProductTitleWidget(
                  title: "Product Details",
                  value: "Lorem Ipsum Dor",
                ),
                ProductTitleWidget(title: "Price", value: "\$199.99"),
                ...List.generate(getInfoList(type).length, (index)=> ProductTitleWidget(
                  title: getInfoList(type)[index].title,
                  value: getInfoList(type)[index].description,
                )),
                if(type == "Instant Sales")...[
                  10.ph,
                  Row(
                    children: [
                      Text("Listing Schedule Calender", style: context.textStyle.displayMedium,),
                    ],
                  ),
                  ProductTitleWidget(title: "Monday", value: "09:00 - 18:00")
                ],
                if(type == "Promotional Products")...[
                  10.ph,
                  Row(
                    children: [
                      Expanded(child: Text("Save Discount For Future Listings")),
                      Icon(Icons.check_box_rounded, color: AppColors.secondaryColor,)
                    ],
                  )
                ]
              ],

            ),
          ),
        ],
      ),
    );
 
  }
}