import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Sales', "User Favorite"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Analytics", bottom:PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: Column(
            children: [
              TabBar(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.r
                ),
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
               
                indicatorWeight: 3,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle: context.textStyle.displaySmall,
                labelStyle:context.textStyle.displaySmall!.copyWith(
                  color: AppColors.primaryColor
                ) ,
                tabs: List.generate(
                  tabs.length,
                  (index) => Tab(
                    child: Text(
                      tabs[index],
                      
                    ),
                  ),
                ),
                onTap: (index) {
                  setState(() {}); // Rebuild to update text color
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ) , child: TabBarView(
        controller: _tabController,
        children: [
          SalesView(),
          UserFavoriteView()
        ],
      ),);
  }
}