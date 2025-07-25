import 'package:flutter/gestures.dart';
import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/views/auth/otp_view.dart';

import '../../export_all.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    super.initState();
  }

  bool showPass = true;
  bool showConfirmPass = true;
  bool rememberMeCheck = false;
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      bottomWidget: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.textStyle.bodyMedium!,

                children: [
                  TextSpan(text: "You Already Have An Account?"),
                  TextSpan(
                    text: " Sign In",
                    style: context.textStyle.bodyMedium!.copyWith(
                      color: context.colors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
          ..onTap = () {
           AppRouter.pushReplacement(LoginView());
          },
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.textStyle.bodyMedium!.copyWith(
                  color: context.colors.primary,
                ),

                children: [
                  TextSpan(text: "Terms & Conditions",  recognizer: TapGestureRecognizer()
          ..onTap = () {
           AppRouter.push(TermConditionsView());
          },),
                  TextSpan(text: "  |  "),
                  TextSpan(text: "Privacy Policy",  recognizer: TapGestureRecognizer()
          ..onTap = () {
           AppRouter.push(PrivacyPolicyView());
          },),
                ],
              ),
            ),
          ],
        ),
      ),
      title: "Sign Up",
      childrens: [
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
        10.ph,
        TextFormField(
          controller: passwordTextController,
          obscureText: showPass,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: AppColors.secondaryColor),

            labelText: "Password",
            hintText: "Enter Password",

            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass = !showPass;
                });
              },
              icon: Icon(
                showPass ? Icons.visibility : Icons.visibility_off,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
        10.ph,
        TextFormField(
          controller: confirmPasswordTextController,
          obscureText: showConfirmPass,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: AppColors.secondaryColor),

            labelText: "Confirm Password",
            hintText: "Enter Confirm Password",

            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showConfirmPass = !showConfirmPass;
                });
              },
              icon: Icon(
                showPass ? Icons.visibility : Icons.visibility_off,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
        // 10.ph,
        
        20.ph,
        CustomButtonWidget(title: "sign up", onPressed: () {
          AppRouter.push(OtpView(
            isSignup: true,
          ));
        }),
      ],);

  }
}