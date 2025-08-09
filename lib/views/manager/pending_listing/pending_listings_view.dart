import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingListingView extends StatefulWidget {
  final ScrollController scrollController;
  const PendingListingView({super.key, required this.scrollController});

  @override
  State<PendingListingView> createState() => _PendingListingViewState();
}

class _PendingListingViewState extends State<PendingListingView> {
 
  List<String> types = [
    "Best By Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products"
  ];
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.22,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: AppConstant.userType == UserType.employee ? "Product Listings - Select Product" : "Pending Listing - Select Product",
        children: [
          15.ph,
             Expanded( 
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.r,
                vertical: 8.r
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryAppBarColor,
                borderRadius: BorderRadius.circular(30.r)
              ),
              child: Column(
                spacing: 8,
  children: [
    for (int i = 0; i < types.length; i += 2)
      Expanded(
        child: Row(
          spacing: 8,
          children: [
            // First item in the row
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = i;
                  });
                },
                child: Container(
                  // margin: EdgeInsets.only(bottom: 8),
                  // padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectIndex == i
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.r),
                    border: selectIndex == i
                        ? null
                        : Border.all(color: AppColors.borderColor),
                  ),
                  child: Text(
                    types[i],
                    style: selectIndex == i
                        ? context.textStyle.displaySmall!
                            .copyWith(color: Colors.white)
                        : context.textStyle.bodySmall!
                            .copyWith(color: AppColors.primaryTextColor),
                  ),
                ),
              ),
            ),
        
          
        
            // Second item in the row (check if it exists)
            if (i + 1 < types.length)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectIndex = i + 1;
                    });
                  },
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 8),
                    // padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectIndex == i + 1
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30.r),
                      border: selectIndex == i + 1
                          ? null
                          : Border.all(color: AppColors.borderColor),
                    ),
                    child: Text(
                      types[i + 1],
                      style: selectIndex == i + 1
                          ? context.textStyle.displaySmall!
                              .copyWith(color: Colors.white)
                          : context.textStyle.bodySmall!
                              .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ),
                ),
              )
            else
              Expanded(child: SizedBox()), // Filler if odd number
          ],
        ),
      ),
  
  ],
)


            
            ),
          )
      ],
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding
            ),
            child: CustomSearchBarWidget(hintText: "Hinted search text", suffixIcon: SvgPicture.asset(Assets.filterIcon),onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            } ),
          ),
          Expanded(
            child: ListView.separated(
              controller: widget.scrollController,
              padding: EdgeInsets.all(AppTheme.horizontalPadding).copyWith(
                bottom: 100.r
              ),
              itemBuilder: (context, index)=>ProductDisplayWidget(
                onTap: (){
                  AppRouter.push(PendingProductDetailView(
                    type: types[selectIndex],
                  ));
                },
              ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10),
          )
        ],
      ),
    );
  }

}
