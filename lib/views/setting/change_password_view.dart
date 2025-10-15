import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late final TextEditingController existingTextController;
  late final TextEditingController newPassTextController;
  late final TextEditingController confirmPassTextController;
  @override
  void initState() {
    existingTextController = TextEditingController();
    newPassTextController = TextEditingController();
    confirmPassTextController = TextEditingController();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
     
      title: context.tr("change_password"), child: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
          GenericPasswordTextField(
            controller: existingTextController,
            
              hint: context.tr("existing_password"),
              label: context.tr("enter_your_password")
            
          ),
          10.ph,
          GenericPasswordTextField(
            
              controller: newPassTextController,
              hint: context.tr("new_password"),
              label: context.tr("new_password")
            
          ),
          10.ph,
          GenericPasswordTextField(
              controller: confirmPassTextController,
              hint: context.tr("confirm_password"),
              label: context.tr("confirm_password")
          
          ),
          10.ph,
          CustomButtonWidget(title: context.tr("change_password_lowercase"), onPressed: (){})
        ],
      ));
  }
}