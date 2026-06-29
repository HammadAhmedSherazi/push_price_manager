import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomScreenTemplate extends StatelessWidget {
  final String title;
  final VoidCallback? onBackCall;
  final bool? showBottomButton;
  final String? bottomButtonText;
  final Widget? customBottomWidget;
  final VoidCallback? onButtonTap;
  final Widget? actionWidget;
  final Widget child;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? bottom;

  const CustomScreenTemplate({
    super.key,
    required this.title,
    this.bottomButtonText,
    this.customBottomWidget,
    this.showBottomButton = false,
    this.onBackCall,
    this.onButtonTap,
    required this.child,
    this.actionWidget,
    this.bottom,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    const backButtonSize = CustomBackWidget.defaultSize;
    final titleSideInset = backButtonSize.iw + 12.iw;
    final appBarHorizontalPadding = 16.iw;

    return SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.only(bottom: 10.ih),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.innerAppBarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            toolbarHeight: 56.ih,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: bottom,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top,
                left: appBarHorizontalPadding,
                right: context.pageHorizontalPadding,
              ),
              child: SizedBox(
                height: 56.ih,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackWidget(onTap: onBackCall),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: titleSideInset),
                      child: Text(
                        title,
                        style: context.textStyle.labelMedium,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (actionWidget != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: actionWidget!,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: child),
            20.ph,
            if (showBottomButton ?? false) ...[
              customBottomWidget ??
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.pageHorizontalPadding,
                    ),
                    child: CustomButtonWidget(
                      title: bottomButtonText ?? "",
                      onPressed: onButtonTap,
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
