import 'package:push_price_manager/utils/extension.dart';
import '../../../export_all.dart';

class LiveListingView extends StatefulWidget {
  final ScrollController scrollController;
  const LiveListingView({super.key, required this.scrollController});

  @override
  State<LiveListingView> createState() => _LiveListingViewState();
}

class _LiveListingViewState extends State<LiveListingView> {
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
        title: "Live Listing- Select Product",
        children: [
          15.ph,
          Expanded( 
            child: Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: AppColors.primaryAppBarColor,
                borderRadius: BorderRadius.circular(30.r)
              ),
              child: GridView.builder(
                padding: EdgeInsets.zero,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // 👈 2 items per row
    crossAxisSpacing: 5,
    mainAxisSpacing: 8,
    childAspectRatio: 4.3, // Adjust this as needed
  ),
  itemCount: types.length,
  itemBuilder: (context, index) {
    final bool isSelect = selectIndex == index;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectIndex = index;
        });
       

      },
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelect ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(30.r),
              left: Radius.circular(30.r)
            ),
            border: !isSelect ? Border.all(color: AppColors.borderColor) : null
          ),
          child: Text(types[index], style: isSelect? context.textStyle.displaySmall!.copyWith(
            color:  Colors.white ,
      
          ) : context.textStyle.bodySmall!.copyWith(
            color: AppColors.primaryTextColor
          ),),
      ),
    );
  },
),
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
            child: CustomSearchBarWidget(hintText: "Hinted search text", suffixIcon: SvgPicture.asset(Assets.filterIcon), onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            }),
          ),
        //   Expanded(
        //     child: ListView.separated(
        //       controller: widget.scrollController,
        //       padding: EdgeInsets.all(AppTheme.horizontalPadding).copyWith(
        //         bottom: 100.r
        //       ),
        //       itemBuilder: (context, index)=>ProductDisplayWidget(
        //         onTap: (){
        //            AppRouter.push(ProductLiveListingDetailView(
        //   type: types[selectIndex],
        //  ));
        //         },
        //       ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10),
        //   )
        ],
      ),
    );
  }


}

