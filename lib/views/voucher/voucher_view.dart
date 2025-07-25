import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class VoucherView extends StatelessWidget {
  const VoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Vouchers", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 15.r,
            horizontal: 20.r
          ),
          decoration: AppTheme.boxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                spacing: 10,
                children: [
                  SvgPicture.asset(Assets.menuVoucherIcon, width: 40.r, height: 40.r,),
                  Text("Get 10% off your next order!", style: context.textStyle.displayMedium!.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 18.sp
                  ),)
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.r,
                  vertical: 5.r
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30.r),
                    right: Radius.circular(30.r)
                  ),
                  border: Border.all(
                    color: AppColors.borderColor,
                    
                  )
                ),
                child: Text("Minimum spend \$0 Expires on April 30, 2025", style: context.textStyle.displaySmall,),
              )
            ],
          ),
        )
      ],
    ));
  }
}