import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class AddDiscountView extends StatefulWidget {
  final bool? isPromotionalDiscount;
  final bool? isInstant;
  const AddDiscountView({super.key, this.isPromotionalDiscount = false, this.isInstant = false});

  @override
  State<AddDiscountView> createState() => _AddDiscountViewState();
}

class _AddDiscountViewState extends State<AddDiscountView> {

  List<String> titles =  [
  'Save Discount For Future Listings',
  'Save Duration of Listing Start Date in Accordance with the Best By Date for future Listings',
  'Resume Automatically For The Next Batch',
];


List<bool> values = [false, false, true];
int selectedIndex = -1;
  @override
  void initState() {
    if(widget.isPromotionalDiscount!){
      titles = ['Save Discount For Future Listings'];
      values = [false];
    }
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: (){
        if(widget.isInstant!){
          AppRouter.push(ListScheduleCalenderView());
        }
        else{
           AppRouter.push(SelectProductView());
        }
        
      },
      title: "Add Discount", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
         TextFormField(
          onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
                  decoration: InputDecoration(
                    hintText: "Current Discount",
                    suffixIcon:  Icon(
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
                  decoration: InputDecoration(
                    hintText: "Daily Increasing Discount",
                    suffixIcon:  Icon(
                Icons.percent_sharp,
                color: AppColors.secondaryColor,
              ),
                  ),
                ),
                10.ph,
            CustomDateSelectWidget(label: "label", hintText: "Listing Start Date", onDateSelected: (date){}),
            20.ph,

            ...List.generate(titles.length, (index)=>Row(
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
          side: BorderSide(
            color: AppColors.secondaryColor
          ),
          value: index == selectedIndex, onChanged: (v){
          setState(() {
            selectedIndex = index;
          });
        },activeColor: AppColors.secondaryColor, ),
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
    ))]));
  }
}

// Define the enum or value type used to track selection


// In your widget state:


// Example inside your widget build method:
