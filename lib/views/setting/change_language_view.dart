import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  String lang = "en";
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Select Language", child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectLanguageWidget(
              title: "English (Default)",
              icon: Assets.engFlagIcon,
              isSelect: lang == "en",
              onTap: () {
                setState(() {
                  lang = "en";
                });
              },
            ),
            10.ph,
            SelectLanguageWidget(
              title: "Spanish",
              icon: Assets.spainFlagIcon,
              isSelect: lang == "sp",
              onTap: () {
                setState(() {
                  lang = "sp";
                });
              },
            ),
            20.ph,
           CustomButtonWidget(
                    title: "save",
                    onPressed: () {
                     AppRouter.back();
                    },
                  )
          ],
        ),
      ),
   );
  }
}