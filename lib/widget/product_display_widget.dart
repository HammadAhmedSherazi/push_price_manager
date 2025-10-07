import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ProductDataModel data;
  const ProductDisplayWidget({
    super.key,
    required this.onTap,
    required this.data

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
          DisplayNetworkImage(imageUrl: data.image,width: 57.r, height: 57.r,),
          Expanded(child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: context.textStyle.bodyMedium,),
              Row(
                children: [
                  Expanded(
                    child: Text(data.description, style:  context.textStyle.bodySmall!.copyWith(
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