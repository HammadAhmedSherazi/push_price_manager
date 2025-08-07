import 'package:flutter/gestures.dart';
import 'package:push_price_manager/utils/extension.dart';



import '../../export_all.dart';

class OtpView extends StatefulWidget {
  final bool isSignup;
  const OtpView({super.key, this.isSignup = false});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool resetTimeChk = false;
  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      bottomWidget: resetTimeChk? RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.textStyle.bodyMedium!,

          children: [
            TextSpan(text: "Didn't receive the OTP?"),
            TextSpan(
              text: " Resend",
              style: context.textStyle.bodyMedium!.copyWith(
                color: context.colors.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // AppRouter.push(SignUpView());
                  setState(() {
                resetTimeChk = false;
              });
                },
            ),
          ],
        ),
      ) : null,
      title: "OTP",
      childrens: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppTheme.horizontalPadding,
          ),
          child: Text(
            "We have sent you an email containing 6 digits verification code. Please enter the code to verify your identityh",
            textAlign: TextAlign.center,
            style: context.textStyle.titleMedium,
          ),
        ),
        20.ph,
        OtpTextField(
          numberOfFields: 6,
          
          onSubmit: (value) {
            if (widget.isSignup) {
              AppRouter.push(CreateProfileView());
            } else {
              AppRouter.push(NewPasswordView());
            }
            // AppRouter.push()
          },
          fieldWidth: (context.screenwidth / 6) * 0.75,
          keyboardType: TextInputType.number,

          hasCustomInputDecoration: true,
          filled: true,

          decoration: InputDecoration(
            counterText: '',
            focusedBorder: context.inputTheme.focusedBorder,
            enabledBorder: context.inputTheme.enabledBorder,
            errorBorder: context.inputTheme.errorBorder,
          ),
        ),
        80.ph,

        Center(
          child: CustomCircularCountdownTimer(
            durationInSeconds: 45,
            size: 180,
            progressColor: AppColors.secondaryColor,
            backgroundColor: Colors.grey.shade300,
            textStyle: context.textStyle.labelMedium!.copyWith(
              color: Colors.white,
            ),
            reset: resetTimeChk,
           
            onComplete: () {
              setState(() {
                resetTimeChk = true;
              });
              // print("⏰ Countdown complete!");
            },
          ),
        ),
      ],
    );
  }
}
