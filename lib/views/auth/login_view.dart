import 'package:flutter/gestures.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController userNameTextController;
  late final TextEditingController passwordTextController;

  @override
  void initState() {
    final sharedPref = SharedPreferenceManager.sharedInstance;
   
    rememberMeCheck = sharedPref.getRemberMe() ?? false;
    sharedPref.clearAll();
    if(rememberMeCheck){
      userNameTextController = TextEditingController(text: sharedPref.getSavedEmail());
      passwordTextController = TextEditingController(text: sharedPref.getSavedPassword());
    }
    else{
       userNameTextController = TextEditingController();
       passwordTextController = TextEditingController();
    }
    super.initState();
  }


  bool rememberMeCheck = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AuthScreenTemplateWidget(
      
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
                    TextSpan(text: context.tr("terms_conditions"),  recognizer: TapGestureRecognizer()
            ..onTap = () {
             AppRouter.push(TermConditionsView());
            },),
                    TextSpan(text: "  |  "),
                    TextSpan(text: context.tr("privacy_policy"),  recognizer: TapGestureRecognizer()
            ..onTap = () {
             AppRouter.push(PrivacyPolicyView());
            },),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        title: context.tr("sign_in"),
        
        childrens: [
          TextFormField(
            controller: userNameTextController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value?.validateUsername(),
            onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.secondaryColor,
              ),
      
              labelText: context.tr("username"),
              hintText: context.tr("enter_username"),
            ),
          ),
          10.ph,
          GenericPasswordTextField(controller: passwordTextController, label: context.tr("password"), hint: context.tr("enter_password"),validator: (value) => value?.validatePassword(), ),
          
          // 10.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSwitchWidget(
                scale: 0.8,
                  value: rememberMeCheck,
                  onChanged: (value) {
                    rememberMeCheck = value;
                    SharedPreferenceManager.sharedInstance.setRemberMe(rememberMeCheck);
                    setState(() {});
                  },
                
              ),
              Text(context.tr("remember_me"), style: context.textStyle.displayMedium),
              Spacer(),
              // TextButton(
              //   onPressed: () {
              //     AppRouter.push(ForgotPasswordView());
              //   },
              //   child: Text(
              //     "Forgot Password?",
              //     style: context.textStyle.displayMedium!.copyWith(
              //       color: context.colors.primary,
              //     ),
              //   ),
              // ),
            ],
          ),
          20.ph,
          Consumer(
            builder: (context,ref, child) {
              final authVM = ref.watch(authProvider);
              return CustomButtonWidget(
                isLoad: authVM.loginApiResponse.status == Status.loading,
                title: context.tr("sign_in"), onPressed: () {
                if(_formKey.currentState!.validate()){
                  final prefs = SharedPreferenceManager.sharedInstance;
                  if(rememberMeCheck){
                    
                    prefs.storeEmail(userNameTextController.text);
                    prefs.storePass(passwordTextController.text);
                  }
                  else{
                    prefs.clearKey(prefs.email);
                    prefs.clearKey(prefs.pass);
                  }
                  ref.read(authProvider.notifier).login(email: userNameTextController.text.trim(), password: passwordTextController.text.trim());
                }
              });
            }
          ),
        ],
      ),
    );
  }
}
