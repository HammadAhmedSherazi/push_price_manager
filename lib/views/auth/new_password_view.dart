import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      title: "Forgot Password",
      onBackTap: (){
        AppRouter.customback(times: 2);
      },
      childrens: [
        GenericPasswordTextField(
          controller: passwordTextController,

          label: "Password",
          hint: "Enter Password",
        ),
        10.ph,
        GenericPasswordTextField(
          controller: confirmPasswordTextController,

          label: "Confirm Password",
          hint: "Enter Confirm Password",
        ),

        // 10.ph,
        20.ph,
        CustomButtonWidget(
          title: "confirm password",
          onPressed: () {
            AppRouter.customback(times: 3);
          },
        ),
      ],
    );
  }
}
