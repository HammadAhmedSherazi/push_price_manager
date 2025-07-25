import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool notificationOn = false;
  bool travelModeOn = false;
  final List<MenuDataModel> menuList = [
    MenuDataModel(
      title: "Push Notifications",
      icon: Assets.notificationToggleIcon,
      onTap: () {},
    ),
    MenuDataModel(
      title: "Travel Mode",
      icon: Assets.travelModeIcon,
      onTap: () {},
    ),
    MenuDataModel(
      title: "Change Language",
      icon: Assets.languageIcon,
      onTap: () {
        AppRouter.push(ChangeLanguageView());
      },
    ),
    MenuDataModel(
      title: "Change Password",
      icon: Assets.securityIcon,
      onTap: () {
        AppRouter.push(ChangePasswordView());

      },
    ),
    MenuDataModel(
      title: "Privacy Policy",
      icon: Assets.privacyIcon,
      onTap: () {
        AppRouter.push(PrivacyPolicyView());
      },
    ),
    MenuDataModel(
      title: "Terms & Conditions",
      icon: Assets.termConditionIcon,
      onTap: () {
        AppRouter.push(TermConditionsView());
      },
    ),
    MenuDataModel(title: "About App", icon: Assets.aboutIcon, onTap: () {
      AppRouter.push(AboutAppView());
    }),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      title: "Settings",
      child: ListView.separated(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        itemBuilder: (context, index) {
          final menu = menuList[index];
          final isNotification = menu.icon == Assets.notificationToggleIcon;
          final isTravelMode = menu.icon == Assets.travelModeIcon;
          return Container(
            decoration: AppTheme.boxDecoration,
            child: ListTile(
              horizontalTitleGap: 1.6,
              onTap: menu.onTap,
              leading: SvgPicture.asset(menu.icon),
              title: Text(menu.title, style: context.textStyle.bodyMedium),
              trailing: isNotification || isTravelMode
                  ? CustomSwitchWidget(
                      scale: 0.7,
                      value: isNotification ? notificationOn : travelModeOn,
                      onChanged: (val) {
                        setState(() {
                          if (isNotification) {
                            notificationOn = val;
                          } else {
                            travelModeOn = val;
                          }
                        });
                      },
                    )
                  : null,
            ),
          );
        },
        separatorBuilder: (context, index) => 10.ph,
        itemCount: menuList.length,
      ),
    );
  }
}
