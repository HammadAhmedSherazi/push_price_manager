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
        padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.checkCircleIcon),
            Text(
              "Thankyou!",
              style: context.textStyle.displayMedium!.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            Text(
              message,
              style: context.textStyle.displayMedium!.copyWith(fontSize: 16.sp),
            ),

            Consumer(
              builder: (context, ref, child) {
                return CustomButtonWidget(
                  title: context.tr("go_home"),
                  onPressed: () {
                    AppRouter.back();
                    if (AppConstant.userType == UserType.employee) {
                      ref
                          .read(productProvider.notifier)
                          .getListApprovedProducts(limit: 10, skip: 0);
                      ref
                          .read(productProvider.notifier)
                          .getListRequestProducts(limit: 10, skip: 0);
                    } else {
                      ref
                          .read(productProvider.notifier)
                          .getPendingReviewList(limit: 10, skip: 0);
                      ref
                          .read(productProvider.notifier)
                          .getLiveListProducts(limit: 10, skip: 0);
                    }
                    // AppRouter.pushAndRemoveUntil(NavigationView());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
