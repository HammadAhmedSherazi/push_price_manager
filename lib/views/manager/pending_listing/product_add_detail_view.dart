import 'package:push_price_manager/utils/extension.dart';
import '../../../export_all.dart';

class ProductAddDetailView extends StatefulWidget {
  final String title;
  const ProductAddDetailView({super.key, required this.title});

  @override
  State<ProductAddDetailView> createState() => _ProductAddDetailViewState();
}

class _ProductAddDetailViewState extends State<ProductAddDetailView> {
  final List<String> types = [
  "Best By Products",
  "Instant Sales",
  "Weighted Items",
  "Promotional Products"
];
String selectType = "";
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
      bottomButtonText: "next",
      onButtonTap: (){
        AppRouter.push(AddDiscountView(
          isInstant: types[1] == selectType,
          
        ));
      },
      title: widget.title, child: ListView(
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
              vertical: 15.r,
              horizontal: AppTheme.horizontalPadding,
            ),
            child: Column(
              spacing: 10,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product Name (Pre-filled)"
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Store Name (Pre-filled)"
                  ),
                ),
                TextFormField(
                  minLines: 4,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Product Details (Pre-filled)",
                    
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product Category (Pre-filled)"
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product Price (Pre-filled)"
                  ),
                ),
                CustomDropDown(
                  onChanged: (value) {
                    if(value != null){
                       setState(() {
                      selectType = value;
                    });
                    }
                   
                  },
                  placeholderText: "Select List Type",
                  options:  types.map((type) {
  return CustomDropDownOption(value: type, displayOption: type);
}).toList(),
                ),
                if(selectType == types[0] || selectType == types[2])
                CustomDateSelectWidget(label: "Date", hintText: "Select a Best Date", onDateSelected: (date){}),
                Row(
                  children: [
                    Text("Product Qunatity", style: context.textStyle.displayMedium,),
                  ],
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}