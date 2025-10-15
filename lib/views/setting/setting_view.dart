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
  
  List<MenuDataModel> _getMenuList(BuildContext context) {
    return [
      MenuDataModel(
        title: context.tr("push_notifications"),
        icon: Assets.notificationToggleIcon,
        onTap: () {},
      ),
      // MenuDataModel(
      //   title: context.tr("travel_mode"),
      //   icon: Assets.travelModeIcon,
      //   onTap: () {},
      // ),
      MenuDataModel(
        title: context.tr("change_language"),
        icon: Assets.languageIcon,
        onTap: () {
          AppRouter.push(ChangeLanguageView());
        },
      ),
      // MenuDataModel(
      //   title: context.tr("change_password"),
      //   icon: Assets.securityIcon,
      //   onTap: () {
      //     AppRouter.push(ChangePasswordView());
      //   },
      // ),
      MenuDataModel(
        title: context.tr("privacy_policy"),
        icon: Assets.privacyIcon,
        onTap: () {
          AppRouter.push(PrivacyPolicyView());
        },
      ),
      MenuDataModel(
        title: context.tr("terms_conditions"),
        icon: Assets.termConditionIcon,
        onTap: () {
          AppRouter.push(TermConditionsView());
        },
      ),
      MenuDataModel(
        title: context.tr("about_app"), 
        icon: Assets.aboutIcon, 
        onTap: () {
          AppRouter.push(AboutAppView());
        }
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    final menuList = _getMenuList(context);
    return CustomScreenTemplate(
      title: context.tr("settings"),
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
