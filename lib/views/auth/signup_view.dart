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
                  TextSpan(text: context.tr("you_already_have_an_account?")),
                  TextSpan(
                    text: " ${context.tr("sign_in")}",
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
                    text: context.tr("terms_conditions"),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppRouter.push(TermConditionsView());
                      },
                  ),
                  TextSpan(text: "  |  "),
                  TextSpan(
                    text: context.tr("privacy_policy"),
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
      title: context.tr("sign_up"),
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

            labelText: context.tr("email"),
            hintText: context.tr("enter_email_address"),
          ),
        ),
        10.ph,
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
          title: context.tr("sign_up"),
          onPressed: () {
            AppRouter.push(OtpView(isSignup: true));
          },
        ),
        10.ph,
        CustomOutlineButtonWidget(
          title: context.tr("continue_with_google"),
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
                  context.tr("continue_with_google"),
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
            title: context.tr("continue_with_apple"),
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
                    context.tr("continue_with_apple"),
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
