
import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key});

  @override
  ConsumerState<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> {
  // bool _isBottomBarVisible = true;

  final ScrollController scrollController = ScrollController();
  final ScrollController drawerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(() {
    //   final direction = scrollController.position.userScrollDirection;
    //   if (direction == ScrollDirection.reverse && _isBottomBarVisible) {
    //     setState(() => _isBottomBarVisible = false);
    //   } else if (direction == ScrollDirection.forward && !_isBottomBarVisible) {
    //     setState(() => _isBottomBarVisible = true);
    //   }
    // });
  }
  
  List<BottomDataModel> _getBottomNavItems(BuildContext context) {
    return AppConstant.userType == UserType.employee ? [
      BottomDataModel(title: context.tr("home"), icon: Assets.home, child: EmployeeHomeView(scrollController: scrollController ,)),
      BottomDataModel(title: context.tr("listing_requests"), icon: Assets.productRequestIcon, child: EmployeeListRequestView(scrollController: scrollController,)),
      BottomDataModel(title: context.tr("product_listing"), icon: Assets.productListingIcon, child: PendingListingView(scrollController: scrollController,)),
      BottomDataModel(title: context.tr("profile"), icon: Assets.profile, child: ProfileView()),
    ] :[
      BottomDataModel(title: context.tr("home"), icon: Assets.home, child: HomeView(scrollController: scrollController ,)),
      BottomDataModel(title: context.tr("pending_listings"), icon: Assets.pendingListing, child: PendingListingView(scrollController: scrollController,)),
      BottomDataModel(title: context.tr("live_listings"), icon: Assets.liveListing, child: LiveListingView(scrollController: scrollController,)),
      BottomDataModel(title: context.tr("profile"), icon: Assets.profile, child: ProfileView()),
    ];
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFFF2F7FA),
          child: Padding(
            padding: EdgeInsets.all(AppTheme.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.tr('logout'), style: context.textStyle.displayMedium!.copyWith(fontSize: 18.sp)),
                10.ph,
                Text(
                  context.tr('are_you_sure_you_want_to_logout'),
                  textAlign: TextAlign.center,
                  style: context.textStyle.bodyMedium!.copyWith(color: Colors.grey),
                ),
                30.ph,
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomOutlineButtonWidget(
                        title: context.tr("cancel"),
                        onPressed: () => AppRouter.back(),
                      ),
                    ),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          return CustomButtonWidget(
                            title: context.tr("logout"),
                            onPressed: () {
                              ref.read(authProvider.notifier).logout();
                            },
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 

  List<MenuDataModel> _getMenuData(BuildContext context) {
    return AppConstant.userType == UserType.employee ? [
      MenuDataModel(title: context.tr("home"), icon: Assets.menuHomeIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(0);
      }),
      MenuDataModel(title: context.tr("listing_request"), icon: Assets.menuProductRequestIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(1);
      }),
      MenuDataModel(title: context.tr("product_listing"), icon: Assets.menuProductListIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(2);
      }),

      MenuDataModel(title: context.tr("profile"), icon: Assets.menuProfileIcon, onTap: () {
        AppRouter.back();
        ref.read(authProvider.notifier).getMyStores();
        ref.read(navigationProvider.notifier).setIndex(3);
      }),
      MenuDataModel(title: context.tr("settings"), icon: Assets.menuSettingIcon, onTap: () => AppRouter.push(SettingView())),
      MenuDataModel(title: context.tr("tutorial"), icon: Assets.menuTutorialIcon, onTap: () {
        AppRouter.push(TutorialView(isOnboarding: false,));
      }),
      MenuDataModel(title: context.tr("help_and_feedback"), icon: Assets.menuHelpIcon, onTap: () => AppRouter.push(HelpFeedbackView())),
    ]: [
      MenuDataModel(title: context.tr("home"), icon: Assets.menuHomeIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(0);
      }),
      MenuDataModel(title: context.tr("pending_listings"), icon: Assets.menuPendingListingIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(1);
      }),
      MenuDataModel(title: context.tr("live_listings"), icon: Assets.menuOrderIcon, onTap: () {
        AppRouter.back();
        ref.read(navigationProvider.notifier).setIndex(2);
      }),
      //  MenuDataModel(title: "Analytics", icon: Assets.menuAnaylicIcon, onTap: () {
      //   AppRouter.push(AnalyticsView());
      // }),
      MenuDataModel(title: context.tr("profile"), icon: Assets.menuProfileIcon, onTap: () {
        AppRouter.back();
        ref.read(authProvider.notifier).getMyStores();
        ref.read(navigationProvider.notifier).setIndex(3);
      }),
      MenuDataModel(title: context.tr("settings"), icon: Assets.menuSettingIcon, onTap: () => AppRouter.push(SettingView())),
      MenuDataModel(title: context.tr("tutorial"), icon: Assets.menuTutorialIcon, onTap: () {
        AppRouter.push(TutorialView());
      }),
      MenuDataModel(title: context.tr("help_and_feedback"), icon: Assets.menuHelpIcon, onTap: () => AppRouter.push(HelpFeedbackView())),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final menuData = _getMenuData(context);
    final bottomNavItems = _getBottomNavItems(context);
    return Scaffold(
      key: AppRouter.scaffoldkey,
      drawerEnableOpenDragGesture: false,
      extendBody: true,
      drawer: SafeArea(
        top: true,
        bottom: false,
        child: Drawer(
          width: context.screenwidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(30.r)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 15.r,
                top: 15.r,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 30.r,
                    width: 30.r,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 18.r, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 60.r,
                child: GestureDetector(
                  onTap: () => showLogoutDialog(context),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(50.r)),
                    ),
                    height: 45.h,
                    width: context.screenwidth * 0.48,
                    child: Row(
                      spacing: 20,
                      children: [
                        const Icon(Icons.exit_to_app, color: Colors.white),
                        Text(
                          context.tr("logout"),
                          style: context.textStyle.headlineMedium!.copyWith(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  50.ph,
                  Consumer(
                    builder: (context, ref, child) {

                      final user = ref.watch(authProvider.select((e)=>e.staffInfo))!;
                      return Center(
                        child: Column(
                          spacing: 7,
                          children: [
                            UserProfileWidget(radius: 45.r, imageUrl: user.profileImage),
                            5.ph,
                            Text(user.fullName, style: context.textStyle.headlineMedium!.copyWith(fontSize: 18.sp)),
                            Text(user.email, style: context.textStyle.bodyMedium),
                          ],
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: context.screenheight * 0.48,
                    child: Scrollbar(
                      trackVisibility: true,
                      thumbVisibility: true,
                      controller: drawerScrollController,
                      child: ListView(
                        primary: false,
                        controller: drawerScrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.r
                        ).copyWith(
                          top: 20.r
                        ),
                        children: List.generate(menuData.length, (index) {
                          final menu = menuData[index];
                          return ListTile(
                            onTap: menu.onTap,
                            visualDensity: VisualDensity(
                              vertical: -2.0
                            ),
                            leading: SvgPicture.asset(menu.icon,  ),
                            title: Text(menu.title),
                            titleTextStyle: context.textStyle.displayMedium!.copyWith(fontSize: 16.sp),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final selectedIndex = ref.watch(navigationProvider);
          return bottomNavItems[selectedIndex].child;
        },
      ),

      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final selectedIndex = ref.watch(navigationProvider);
          return CustomBottomNavBarWidget(
            items: bottomNavItems,
            currentIndex: selectedIndex,
            onTap: (index) {
              ref.read(navigationProvider.notifier).setIndex(index);
              if(index == 3){
                 ref.read(authProvider.notifier).getMyStores();
              }
            },
          );
        },
      )
      //  AnimatedSlide(
      //   offset: _isBottomBarVisible ? Offset.zero : const Offset(0, 100),
      //   duration: const Duration(milliseconds: 2000),
      //   child: CustomBottomNavBarWidget(
      //     items: bottomNavItems,
      //     currentIndex: selectIndex,
      //     onTap: (index) {
      //       setState(() => selectIndex = index);
      //     },
      //   ),
      // ),
    );
  }
}
