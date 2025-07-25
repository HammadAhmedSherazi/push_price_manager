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
     
      title: "Change password", child: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
          GenericPasswordTextField(
            controller: existingTextController,
            
              hint: "Existing Password",
              label: "Enter your existing password"
            
          ),
          10.ph,
          GenericPasswordTextField(
            
              controller: newPassTextController,
              hint: "New Password",
              label: "Enter new password"
            
          ),
          10.ph,
          GenericPasswordTextField(
              controller: confirmPassTextController,
              hint: "Confirm New Password",
              label: "Enter confimr new password"
          
          ),
          10.ph,
          CustomButtonWidget(title: "change password", onPressed: (){})
        ],
      ));
  }
}