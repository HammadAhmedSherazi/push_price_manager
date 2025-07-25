import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class SubscriptionPlanView extends StatelessWidget {
  final bool? isPro;
  const SubscriptionPlanView({super.key, this.isPro = false});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      customBottomWidget: isPro!
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      title: "subscribe",
                      onPressed: () {
                        AppRouter.pushAndRemoveUntil(NavigationView());
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomOutlineButtonWidget(
                      title: "not now",
                      onPressed: () {
                        AppRouter.push(SubscriptionPlanView());
                      },
                    ),
                  ),
                ],
              ),
            )
          : null,
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: () {
        AppRouter.pushAndRemoveUntil(NavigationView());
      },
      title: "Subscription",
      child: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        children: [
          Center(
            child: Text(
              isPro! ? "Push Price Pro" : "Push Price Free",
              style: context.textStyle.displayMedium!.copyWith(fontSize: 20.sp),
            ),
          ),
          20.ph,
          Container(
            // height:  80.h,
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.secondaryColor,
            ),
            child: Text(
              isPro!
                  ? "People usually save 3x of subscription fees"
                  : "People usually save 30% on grocery",
              textAlign: TextAlign.center,
              style: context.textStyle.displayLarge!.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
          20.ph,
          Text(
            isPro! ? "Pro Perks" : "Free Perks",
            style: context.textStyle.displayMedium!.copyWith(fontSize: 18.sp),
          ),
          15.ph,
          DiscountLIstTitleWidget(
            icon: Assets.discountIcon,
            title: "5% additional discount",
            subtitle: "Unlimited times",
          ),
          DiscountLIstTitleWidget(
            icon: Assets.notificationAlertIcon,
            title: "Get notified for discounts",
            subtitle: isPro! ? "Unlimited times" : "4 times per month",
          ),
          DiscountLIstTitleWidget(
            icon: Assets.travelDiscountIcon,
            title: "5% additional discount",
            subtitle: isPro! ? "Unlimited times" : "1 time per month",
          ),
          20.ph,
          Center(
            child: 

RichText(
  text: TextSpan(
    children: [
      WidgetSpan(
        alignment: PlaceholderAlignment.top,
        child: Transform.translate(
          offset: const Offset(-10, -70), // adjust Y offset as needed
          child: Text(
            '\$',
            style: context.textStyle.bodySmall!.copyWith(
              fontSize: 18.sp,
              
            ),
          ),
        ),
      ),
      TextSpan(
        text: '14',
        style: context.textStyle.headlineLarge!.copyWith(
          fontSize: 80.sp,
          color: AppColors.secondaryColor,
        ),
      ),
      TextSpan(
        text: '.99',
        style: context.textStyle.displayLarge!.copyWith(
          fontSize: 25  .sp,
          color: AppColors.secondaryColor,
        ),
      ),
      TextSpan(
        text: '/month',
        style: context.textStyle.displayLarge!.copyWith(
          fontSize: 18.sp,
        ),
      ),
    ],
  ),
),
          ),
        ],
      ),
    );
  }
}

class DiscountLIstTitleWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const DiscountLIstTitleWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.r),
      padding: EdgeInsets.symmetric(vertical: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: ListTile(
        leading: icon.contains(".png")
            ? Image.asset(icon, width: 42.r, height: 40.r)
            : SvgPicture.asset(icon, width: 42.r, height: 40.r),
        title: Text(title),
        subtitle: Text(subtitle),
        titleTextStyle: context.textStyle.displayMedium!.copyWith(
          fontSize: 18.sp,
        ),
        subtitleTextStyle: context.textStyle.bodyMedium!.copyWith(
          color: Color(0xff5B5B5B),
        ),
      ),
    );
  }
}
