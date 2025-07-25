import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class TermConditionsView extends StatelessWidget {
  const TermConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Terms & Conditions", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        Text(AppConstant.content, style: context.textStyle.bodyMedium,)
      ],
    ));
  }
}