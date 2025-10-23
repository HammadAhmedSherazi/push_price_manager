import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayBoxWidget extends StatelessWidget {
  final ProductDataModel data;
  const ProductDisplayBoxWidget({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
    padding: EdgeInsets.symmetric(
      horizontal: 10.r,
      vertical: 15.r
    ),
    height: double.infinity,
    width: context.screenwidth * 0.35,
    decoration: AppTheme.productBoxDecoration,
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 3,
      children: [
        DisplayNetworkImage(imageUrl: data.image, width: 40.r, height: 40.r,),
        
        5.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Text(data.title, style: context.textStyle.displaySmall, maxLines: 1,)),
          ],
        ),
        Row(
          children: [
            Text("${data.category?.title}", style: context.textStyle.bodySmall,),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("\$ ${data.price?.toStringAsFixed(2)}", style: context.textStyle.titleSmall,)),
            
          ],
        ),
    
      ],
    ),
                        );
  }
}


