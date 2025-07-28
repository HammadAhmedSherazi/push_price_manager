import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductTitleWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProductTitleWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.r),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textStyle.bodyMedium!.copyWith(
            color: Colors.black54
          )),
          Text(value, style: context.textStyle.displayMedium),
        ],
      ),
    );
  }
}