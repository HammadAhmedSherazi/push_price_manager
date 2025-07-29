import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductDisplayBoxWidget extends StatelessWidget {
  const ProductDisplayBoxWidget({
    super.key,
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
        Image.asset(Assets.groceryBag, width: 40.r,),
        5.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Abc Product", style: context.textStyle.displaySmall,),
          ],
        ),
        Row(
          children: [
            Text("Abc Category", style: context.textStyle.bodySmall,),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("\$ 199.99", style: context.textStyle.titleSmall,)),
            
          ],
        ),
    
      ],
    ),
                        );
  }
}


