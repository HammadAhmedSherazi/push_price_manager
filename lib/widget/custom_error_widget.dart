

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class CustomErrorWidget extends StatelessWidget {
  final bool isLoad;
  final VoidCallback onPressed;
  const CustomErrorWidget(
      {super.key, this.isLoad = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Text( 
          context.tr("something_went_wrong"),
          style: context.textStyle.bodyMedium!.copyWith(fontSize: 16.sp),
          textAlign: TextAlign.center,
        ),
        10.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120.w,
              height: 40.h,
              child: CustomButtonWidget(title: context.tr('load_again'), onPressed: onPressed) 
              
            ),
          ],
        )
      ],
    );
  }
}