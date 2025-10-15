import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: context.tr("privacy_policy"), child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        Text(AppConstant.content, style: context.textStyle.bodyMedium,)
      ],
    ));
  }
}