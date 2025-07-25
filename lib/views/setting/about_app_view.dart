import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "About App", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        Text(AppConstant.content, style: context.textStyle.bodyMedium,)
      ],
    ));
  }
}