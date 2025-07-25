import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tabController,
    required this.tabs
  });

  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      margin:  EdgeInsets.only(
        left: AppTheme.horizontalPadding,
        right: AppTheme.horizontalPadding,
        top: 20.r
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        
        border: Border.all(color: AppColors.borderColor),
      ),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primaryTextColor,
        labelStyle: context.textStyle.bodyMedium,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          
        ),
        tabs: tabs,
      ),
    );
  }
}