import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  static const _avatarRadius = 45.0;
  static const _avatarBottomGap = 16.0;

  @override
  Widget build(BuildContext context) {
    final titleHeight = context.tabAppBarTitleHeight + (context.isTablet ? 24.ih : 16.ih);
    final avatarRadius = _avatarRadius.iw;
    // Blue header covers title + top half of avatar.
    final headerHeight = titleHeight + avatarRadius;
    // Stack also reserves space for the bottom half of the avatar.
    final stackHeight = headerHeight + avatarRadius;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer(
        builder: (context, ref, child) {
          final response =
              ref.watch(authProvider.select((e) => e.getStoresApiRes));
          return AsyncStateHandler(
            status: response.status,
            dataList: const [1],
            itemBuilder: null,
            onRetry: () {
              ref.read(authProvider.notifier).getMyStores();
            },
            customSuccessWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: stackHeight,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: headerHeight,
                        child: CustomAppBarWidget(
                          height: headerHeight,
                          title: context.tr("profile"),
                          children: const [],
                        ),
                      ),
                      Positioned(
                        top: titleHeight,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final image = ref.watch(
                                authProvider.select(
                                  (e) => e.staffInfo?.profileImage ?? '',
                                ),
                              );
                              return UserProfileWidget(
                                radius: _avatarRadius,
                                imageUrl: image,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _avatarBottomGap.ih),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.pageHorizontalPadding,
                    ).copyWith(bottom: context.scrollBottomPadding),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final data = ref.watch(
                          authProvider.select((e) => (e.staffInfo, e.stores)),
                        );
                        final user = data.$1!;
                        final stores = data.$2!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  context.tr("personal_information"),
                                  style: context.textStyle.displayMedium,
                                ),
                              ],
                            ),
                            10.ph,
                            ProfileTitleWidget(
                              title: context.tr("name"),
                              value: user.fullName,
                            ),
                            ProfileTitleWidget(
                              title: context.tr("username"),
                              value: user.username,
                            ),
                            ProfileTitleWidget(
                              title: context.tr("phone_number"),
                              value: user.phoneNumber,
                            ),
                            ProfileTitleWidget(
                              title: context.tr("employee_id"),
                              value: user.staffId.toString(),
                            ),
                            if (AppConstant.userType == UserType.manager &&
                                stores.isNotEmpty) ...[
                              10.ph,
                              Row(
                                children: [
                                  Text(
                                    context.tr("assigned_stores"),
                                    style: context.textStyle.displayMedium,
                                  ),
                                ],
                              ),
                              10.ph,
                              for (var i = 0; i < stores.length; i++) ...[
                                ProfileTitleWidget(
                                  title: context.tr("store_branch_code_name"),
                                  value: stores[i].storeName,
                                ),
                                ProfileTitleWidget(
                                  title: context.tr("store_address"),
                                  value: stores[i].storeLocation,
                                  showOutline: false,
                                ),
                                ProfileTitleWidget(
                                  title: context.tr("operational_hours"),
                                  value: stores[i].storeOperationalHours,
                                  showOutline: false,
                                ),
                              ],
                            ],
                            if (AppConstant.userType == UserType.employee &&
                                stores.isNotEmpty) ...[
                              ProfileTitleWidget(
                                title: context.tr("store_branch_code_name"),
                                value: stores.first.storeName,
                              ),
                              ProfileTitleWidget(
                                title: context.tr("store_address"),
                                value: stores.first.storeLocation,
                              ),
                              ProfileTitleWidget(
                                title: context.tr("operational_hours"),
                                value: stores.first.storeOperationalHours,
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool showOutline;

  const ProfileTitleWidget({
    super.key,
    required this.title,
    required this.value,
    this.showOutline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.ih),
      padding: EdgeInsets.only(
        bottom: 10.ih,
        left: !showOutline ? 10.iw : 0.0,
      ),
      decoration: showOutline
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderColor),
              ),
            )
          : null,
      child: Row(
        children: [
          Text(title, style: context.textStyle.bodyMedium),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.textStyle.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
