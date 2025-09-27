import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ProductSelectionDataModel? product;
  const ProductDisplayWidget({
    super.key,
    required this.onTap,
    this.product,
  });

  bool _isNetworkImage(String? imageUrl) {
    return imageUrl != null && imageUrl.startsWith('http');
  }

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
          _isNetworkImage(product?.image)
            ? CachedNetworkImage(
                imageUrl: product?.image ?? '',
                width: 57.w,
                height: 57.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 57.w,
                  height: 57.w,
                  color: Colors.grey[200],
                  child: Icon(Icons.image, size: 30.w),
                ),
                errorWidget: (context, url, error) => Image.asset(Assets.groceryBag, width: 57.w),
              )
            : Image.asset(
                product?.image ?? Assets.groceryBag, 
                width: 57.w,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(Assets.groceryBag, width: 57.w);
                },
              ),
          Expanded(child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product?.title ?? "Product", 
                style: context.textStyle.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product?.description ?? "Category", 
                      style:  context.textStyle.bodySmall!.copyWith(
                        color: AppColors.primaryTextColor
                            .withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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