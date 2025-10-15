import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/utils/extension.dart';

class SelectLanguageView extends ConsumerStatefulWidget {
  const SelectLanguageView({super.key});

  @override
  ConsumerState<SelectLanguageView> createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends ConsumerState<SelectLanguageView> {
  String lang = "en";
  
  @override
  void initState() {
    super.initState();
    // Get current language from provider
    lang = SharedPreferenceManager.sharedInstance.getLangCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(context.tr("languages"), style: context.textStyle.labelMedium),
      ),
      body: Container(
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
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: CustomOutlineButtonWidget(
                    title: context.tr("skip"),
                    onPressed: () {
                      AppRouter.push(TutorialView());
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonWidget(
                    title: context.tr("continue"),
                    onPressed: () {
                      // Save selected language
                      ref.read(localeProvider.notifier).changeLanguage(lang);
                      AppRouter.push(TutorialView());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectLanguageWidget extends StatelessWidget {
  final String title;
  final bool isSelect;
  final String icon;
  final VoidCallback onTap;
  const SelectLanguageWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 60.h,
         padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 18
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          spacing: 10,
          children: [
            // CircleAvatar(
            //   radius: 20.r,
            //   backgroundColor: Colors.transparent,
            //   backgroundImage: AssetImage(icon),
            // ),
            Expanded(child: Text(title, style: context.textStyle.bodyMedium)),
            Icon(
              isSelect ? Icons.check_circle : Icons.circle_outlined,
              color: AppColors.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
