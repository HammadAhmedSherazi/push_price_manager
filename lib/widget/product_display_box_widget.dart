import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayBoxWidget extends StatelessWidget {
  final ProductSelectionDataModel? product;
  const ProductDisplayBoxWidget({
    super.key,
    this.product,
  });

  bool _isNetworkImage(String? imageUrl) {
    return imageUrl != null && imageUrl.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    
    padding: EdgeInsets.symmetric(
      horizontal: 8.r,
      vertical: 12.r
    ),
    height: double.infinity,
    width: context.screenwidth * 0.35,
    decoration: AppTheme.productBoxDecoration,
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 2,
      children: [
        _isNetworkImage(product?.image)
          ? CachedNetworkImage(
              imageUrl: product?.image ?? '',
              width: 55.r,
              height: 55.r,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 55.r,
                height: 55.r,
                color: Colors.grey[200],
                child: Icon(Icons.image, size: 25.r),
              ),
              errorWidget: (context, url, error) => Image.asset(Assets.groceryBag, width: 55.r),
            )
          : Image.asset(
              product?.image ?? Assets.groceryBag, 
              width: 55.r,
              height: 55.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(Assets.groceryBag, width: 55.r);
              },
            ),
        3.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product?.title ?? "Product", 
                style: context.textStyle.displaySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                product?.description ?? "Category", 
                style: context.textStyle.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text(
              product?.price != null ? "\$ ${product!.price!.toStringAsFixed(2)}" : "\$ 0.00", 
              style: context.textStyle.titleSmall,
            )),
            
          ],
        ),
    
      ],
    ),
                        );
  }
}


