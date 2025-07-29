import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayWidget extends StatelessWidget {
  final VoidCallback onTap;
  const ProductDisplayWidget({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
                vertical: 10.r,
                horizontal: 20.r,
              ),
      decoration: AppTheme.productBoxDecoration,
      child: Row(
        spacing: 10,
        children: [
          Image.asset(Assets.groceryBag, width: 57.w),
          Expanded(child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ABC Product", style: context.textStyle.bodyMedium,),
              Row(
                children: [
                  Expanded(
                    child: Text("ABC Category", style:  context.textStyle.bodySmall!.copyWith(
                                      color: AppColors.primaryTextColor
                                          .withValues(alpha: 0.7),
                                    ),),
                  ),
                  Text("See Details", style: context.textStyle.bodySmall!.copyWith(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline
                  ),)
                ],
              ),
            ],
          ))
        ],
      ),
                ),
    );
  }
}