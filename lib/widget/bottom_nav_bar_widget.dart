import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  final List<BottomDataModel> items;
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 12.ih,
        bottom: context.bottomNavBottomPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.iw)),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: SizedBox(
        height: 56.ih,
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selectColor = currentIndex == index
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.6);
            return Expanded(
              child: InkWell(
                onTap: () => onTap?.call(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppConstant.userType == UserType.manager
                        ? SvgPicture.asset(
                            index == 2 && currentIndex == 2
                                ? Assets.selectliveListing
                                : item.icon,
                            width: 22.iw,
                            height: 22.iw,
                            colorFilter: index != 2
                                ? ColorFilter.mode(selectColor, BlendMode.srcIn)
                                : null,
                          )
                        : SvgPicture.asset(
                            item.icon,
                            width: 22.iw,
                            height: 22.iw,
                            colorFilter:
                                ColorFilter.mode(selectColor, BlendMode.srcIn),
                          ),
                    SizedBox(height: 6.ih),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.textStyle.displaySmall!.copyWith(
                        color: selectColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
