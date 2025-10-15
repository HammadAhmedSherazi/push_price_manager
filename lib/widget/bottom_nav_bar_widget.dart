import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  
  const CustomBottomNavBarWidget({super.key, required this.items, required this.currentIndex, this.onTap});
  final List<BottomDataModel> items;
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: double.infinity,
      height: 80.r,
      alignment: Alignment.center,
     padding: EdgeInsets.only(
      // left: 10.r,
      // right: 10.r,
      top: 15.r,
      // bottom: 30.r
     ),
     
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
        border: Border.all(
          width: 1,
          color: AppColors.borderColor
        )
      ),
      child: Row(
        // spacing: 10,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children:List.generate(items.length, (index) {
          final item = items[index];
          final Color selectColor = currentIndex == index? AppColors.primaryColor : AppColors.primaryColor.withValues(alpha: 0.6);
          return Expanded(
            child: InkWell(
              onTap: (){
                onTap?.call(index);
              },
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                AppConstant.userType == UserType.manager?
                  SvgPicture.asset(   index == 2 && currentIndex == 2? Assets.selectliveListing : item.icon, colorFilter:   index != 2 ?  ColorFilter.mode(selectColor, BlendMode.srcIn) : null ,) : SvgPicture.asset(item.icon,  colorFilter: ColorFilter.mode(selectColor, BlendMode.srcIn),),
                  Expanded(
                    child: Text(item.title, 
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: context.textStyle.displaySmall!.copyWith(
                      color: selectColor
                    ),),
                  )
                      
              ],
                      ),
            ),
          );
        }),
      ),
    );
  }
}

// class BottomNavBarItemWidget extends StatelessWidget {
//   const BottomNavBarItemWidget({
//     super.key,
//     required this.isSelected,
//     required this.onTap,
//     required this.image,
//   });

//   final bool isSelected;
//   final VoidCallback onTap;
//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SvgPicture.asset(
//               image,
//               fit: BoxFit.scaleDown,
//               height: 54,
//               width: 54,
//             ),
//             Text(context.tr("home"),
//               style: TextStyle(
//                 color: isSelected ? AppColorTheme().primary : AppColorTheme().secondaryText,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }