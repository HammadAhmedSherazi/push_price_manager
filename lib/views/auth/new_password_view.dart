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
      title: context.tr("forgot_password"),
      onBackTap: (){
        AppRouter.customback(times: 2);
      },
      childrens: [
        GenericPasswordTextField(
          controller: passwordTextController,

          label: context.tr("password"),
          hint: context.tr("enter_password"),
        ),
        10.ph,
        GenericPasswordTextField(
          controller: confirmPasswordTextController,

          label: context.tr("confirm_password"),
          hint: context.tr("enter_password"),
        ),

        // 10.ph,
        20.ph,
        CustomButtonWidget(
          title: context.tr("confirm_password"),
          onPressed: () {
            AppRouter.customback(times: 3);
          },
        ),
      ],
    );
  }
}
