import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/views/auth/otp_view.dart';

import '../../export_all.dart';


class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController emailTextController;

  @override
  void initState() {
    emailTextController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(title: "Forgot Password", childrens: [
      TextFormField(
          controller: emailTextController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.secondaryColor,
            ),

            labelText: "Email",
            hintText: "Enter Email Address",
          ),
        ),
        20.ph,
        CustomButtonWidget(title: "continue", onPressed: () {
          AppRouter.push(OtpView());
        }),
           
    ]);
  }
}