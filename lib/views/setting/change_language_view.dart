import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ChangeLanguageView extends ConsumerStatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  ConsumerState<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends ConsumerState<ChangeLanguageView> {
  String lang = "en";
  
  @override
  void initState() {
    super.initState();
    // Get current language from provider
    lang = SharedPreferenceManager.sharedInstance.getLangCode();
  }
  
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: context.tr("select_language"), child: Container(
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
              isSelect: lang == "es",
              onTap: () {
                setState(() {
                  lang = "es";
                });
              },
            ),
            20.ph,
           CustomButtonWidget(
                    title: context.tr("save"),
                    onPressed: () {
                      // Update language via provider
                      ref.read(localeProvider.notifier).changeLanguage(lang);
                      AppRouter.back();
                    },
                  )
          ],
        ),
      ),
   );
  }
}