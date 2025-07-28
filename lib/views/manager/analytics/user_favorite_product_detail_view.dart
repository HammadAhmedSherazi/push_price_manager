import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class UserFavoriteProductDetailView extends StatefulWidget {
  const UserFavoriteProductDetailView({super.key});

  @override
  State<UserFavoriteProductDetailView> createState() => _UserFavoriteProductDetailViewState();
}

class _UserFavoriteProductDetailViewState extends State<UserFavoriteProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Favorite Products by User", child: ListView(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.horizontalPadding
      ),
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
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitleWidget(title: "Name of Product", value: "Abc Product"),
                ProductTitleWidget(title: "Total Number of Users", value: "100"),
                ProductTitleWidget(title: "Name of Product", value: "Abc Product"),
                Text("Number of user by state & city", style: context.textStyle.bodyMedium!.copyWith(
                  fontSize: 18.sp
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Texas", style: context.textStyle.displayMedium,),
                    Text("100", style: context.textStyle.displayMedium,),
                  ],
                ),
                Divider(
                  color: AppColors.borderColor,
                  thickness: 1.0,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.circle_outlined, size: 10.r, color: AppColors.secondaryColor,),
                    Text("Houston",),
                    Spacer(),
                    Text("75", style: context.textStyle.displayMedium,),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.circle_outlined, size: 10.r, color: AppColors.secondaryColor,),
                    Text("Dallas",),
                    Spacer(),
                    Text("25", style: context.textStyle.displayMedium,),
                  ],
                ),
                 Divider(
                  color: AppColors.borderColor,
                  thickness: 1.0,
                ),
              ],

            ),
          ),
      ],
    ));
  }
}