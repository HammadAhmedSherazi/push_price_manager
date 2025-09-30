import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class SuccessListingRequestView extends StatelessWidget {
  final String message;
  const SuccessListingRequestView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.horizontalPadding
        ),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.checkCircleIcon),
            Text("Thankyou!", style: context.textStyle.displayMedium!.copyWith(
              color: AppColors.secondaryColor
            ),),
            Text(message, style: context.textStyle.displayMedium!.copyWith(
              fontSize: 16.sp
            ),),
           
            CustomButtonWidget(title: "go home", onPressed: (){
                AppRouter.customback(
                times: 6
              );
              // AppRouter.pushAndRemoveUntil(NavigationView());
            })
          ],
        ),
      ),
    );
  }
}