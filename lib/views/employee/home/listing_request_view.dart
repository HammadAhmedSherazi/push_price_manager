import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListingRequestView extends StatelessWidget {
  const ListingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.15,
        title: "Listing Request - Select Product",
        children: [
          CustomSearchBarWidget(
            hintText: "Hinted search text",
            suffixIcon: SvgPicture.asset(Assets.filterIcon),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.separated(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            itemBuilder: (context, index)=>Container(
              padding: EdgeInsets.symmetric(
                      vertical: 10.r,
                      horizontal: 20.r,
                    ),
            decoration: AppTheme.productBoxDecoration,
            child: Row(
              children: [
                Image.asset(Assets.groceryBag, width: 57.w),
              ],
            ),
          ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10))
        ],
      ),
    );
  }
}
