import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/utils/extension.dart';

class SelectLanguageView extends StatefulWidget {
  const SelectLanguageView({super.key});

  @override
  State<SelectLanguageView> createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<SelectLanguageView> {
  String lang = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Languages", style: context.textStyle.labelMedium),
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
              isSelect: lang == "sp",
              onTap: () {
                setState(() {
                  lang = "sp";
                });
              },
            ),
            20.ph,
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: CustomOutlineButtonWidget(
                    title: "SKIP",
                    onPressed: () {
                      AppRouter.push(SelectUserView());
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonWidget(
                    title: "CONTINUE",
                    onPressed: () {
                      AppRouter.push(SelectUserView());
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
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(icon),
            ),
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
