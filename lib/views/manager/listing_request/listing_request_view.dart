import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingRequestView extends StatelessWidget {
  const ListingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "scan",
      onButtonTap: (){
        AppRouter.push(ScanView());
      },
      title: AppConstant.userType == UserType.employee? "Search From Database": "Listing Request - Select Product", child: Column(
        children: [
          Padding(padding:EdgeInsets.all(AppTheme.horizontalPadding) , child:  CustomSearchBarWidget(
            onTapOutside: (v){
               FocusScope.of(context).unfocus();
              
            },
            hintText: "Hinted search text",
            suffixIcon: SvgPicture.asset(Assets.filterIcon),
          ),),
           Expanded(child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
            itemBuilder: (context, index)=>ProductDisplayWidget(
              onTap: (){},
            ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10))
        ],
      ));
    // return Scaffold(
    //   appBar: CustomAppBarWidget(
    //     height: context.screenheight * 0.15,
    //     title: AppConstant.userType == UserType.employee? "Search From Database": "Listing Request - Select Product",
    //     children: [
          // CustomSearchBarWidget(
          //   hintText: "Hinted search text",
          //   suffixIcon: SvgPicture.asset(Assets.filterIcon),
          // ),
    //     ],
    //   ),
    //   body: Column(
    //     children: [
          // Expanded(child: ListView.separated(
          //   padding: EdgeInsets.all(AppTheme.horizontalPadding),
          //   itemBuilder: (context, index)=>ProductDisplayWidget(
          //     onTap: (){},
          //   ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10)),
    //       Padding(
    //         padding: EdgeInsets.all(AppTheme.horizontalPadding),
    //         child: CustomButtonWidget(title: "scan", onPressed: (){
    //           AppRouter.push(ScanView());
    //         }),
    //       )
    //     ],
    //   ),
    // );
  }
}


