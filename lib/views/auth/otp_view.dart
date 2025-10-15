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
            TextSpan(text: context.tr("didnt_receive_otp")),
            TextSpan(
              text: " ${context.tr("resend")}",
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
      title: context.tr("otp"),
      childrens: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppTheme.horizontalPadding,
          ),
          child: Text(
            context.tr("we_have_sent_you_an_email_containing_6_digits_verification_code_please_enter_the_code_to_verify_your_identity"),
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
