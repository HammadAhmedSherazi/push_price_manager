import 'dart:io';

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
                        AppRouter.back();
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
                  TextSpan(
                    text: "Terms & Conditions",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppRouter.push(TermConditionsView());
                      },
                  ),
                  TextSpan(text: "  |  "),
                  TextSpan(
                    text: "Privacy Policy",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppRouter.push(PrivacyPolicyView());
                      },
                  ),
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
          onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
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
          title: "sign up",
          onPressed: () {
            AppRouter.push(OtpView(isSignup: true));
          },
        ),
        10.ph,
        CustomOutlineButtonWidget(
          title: "Continue with Google",
          onPressed: () {
            AppRouter.pushAndRemoveUntil(NavigationView());
          },
          child: Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.googleIcon),
              SizedBox(
                // color: Colors.red,
                width: context.screenwidth * 0.45,
                child: Text(
                  "Continue with Google",
                  style: context.textStyle.displayMedium!.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        if (Platform.isIOS) ...[
          10.ph,
          CustomOutlineButtonWidget(
            title: "Continue with Google",
            onPressed: () {
              AppRouter.pushAndRemoveUntil(NavigationView());
            },
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.appleIcon),
                SizedBox(
                  // color: Colors.red,
                  width: context.screenwidth * 0.45,
                  child: Text(
                    "Continue with Apple",
                    style: context.textStyle.displayMedium!.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
     
      ],
    );
  }
}
