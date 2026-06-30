import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final List<Widget> children;
  final double? radius;
  final Color? backgroundColor;

  const CustomAppBarWidget({
    super.key,
    required this.height,
    required this.title,
    required this.children,
    this.backgroundColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final actionSize = 40.iw;
    final titleSideInset = actionSize + 8.iw;

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        padding: EdgeInsets.only(
          top: 36.ih,
          left: context.pageHorizontalPadding,
          right: context.pageHorizontalPadding,
          bottom: context.isTablet ? 18.ih : 14.ih,
        ),
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryAppBarColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(radius ?? 35.iw),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: actionSize,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () async {
                        AppRouter.closeKeyboard();
                        await Future.delayed(
                          const Duration(milliseconds: 150),
                        );

                        if (AppRouter
                                .scaffoldkey
                                ?.currentState
                                ?.isDrawerOpen !=
                            true) {
                          AppRouter.scaffoldkey?.currentState?.openDrawer();
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromRGBO(234, 241, 255, 0.6),
                        radius: 20.iw,
                        child: SvgPicture.asset(Assets.menuNavIcon),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: titleSideInset),
                    child: Text(
                      title,
                      style: context.textStyle.displayMedium,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: actionSize),
                ],
              ),
            ),
            if (children.isNotEmpty) ...[
              SizedBox(height: 8.ih),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
