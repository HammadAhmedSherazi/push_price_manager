import 'package:flutter/gestures.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;

  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }


  bool rememberMeCheck = false;

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      onBackTap: (){
        AppRouter.pushAndRemoveUntil(OnboardingView());
      },
      bottomWidget: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          //   RichText(
          //     textAlign: TextAlign.center,
          //     text: TextSpan(
          //       style: context.textStyle.bodyMedium!,

          //       children: [
          //         TextSpan(text: "Don't have an account?"),
          //         TextSpan(
          //           text: " Sign Up",
          //           style: context.textStyle.bodyMedium!.copyWith(
          //             color: context.colors.primary,
          //           ),
          //           recognizer: TapGestureRecognizer()
          // ..onTap = () {
          //   AppRouter.push(SignUpView());
          // },
          //         ),
          //       ],
          //     ),
          //   ),
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
      
      title: "Sign In",
      
      childrens: [
        TextFormField(
          controller: emailTextController,
          keyboardType: TextInputType.emailAddress,
          onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
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
        GenericPasswordTextField(controller: passwordTextController, label: "Password", hint: "Enter Password",),
        
        // 10.ph,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSwitchWidget(
              scale: 0.8,
                value: rememberMeCheck,
                onChanged: (value) {
                  rememberMeCheck = value;
                  setState(() {});
                },
              
            ),
            Text("Remember Me", style: context.textStyle.displayMedium),
            Spacer(),
            TextButton(
              onPressed: () {
                AppRouter.push(ForgotPasswordView());
              },
              child: Text(
                "Forgot Password?",
                style: context.textStyle.displayMedium!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
        20.ph,
        CustomButtonWidget(title: "login", onPressed: () {
          AppRouter.pushAndRemoveUntil(NavigationView());
        }),
      ],
    );
  }
}
