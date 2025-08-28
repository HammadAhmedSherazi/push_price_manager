import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class AuthScreenTemplateWidget extends StatefulWidget {
  final String title;
  final List<Widget> childrens;
  final Widget? bottomWidget;
  final VoidCallback ? onBackTap;
  
  const AuthScreenTemplateWidget({super.key, required this.title, this.bottomWidget, required this.childrens, this.onBackTap});

  @override
  State<AuthScreenTemplateWidget> createState() => _AuthScreenTemplateWidgetState();
}

class _AuthScreenTemplateWidgetState extends State<AuthScreenTemplateWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _logoOffset;
  late Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

     _logoOffset = Tween<Offset>(
  begin: const Offset(-1.0, 0.0), // From left
  end: Offset.zero,
).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

   

   _opacity = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(parent: _controller, curve: Curves.easeIn),
);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      onBackCall: widget.onBackTap,
      title: widget.title, showBottomButton: widget.bottomWidget != null, customBottomWidget: widget.bottomWidget, child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.horizontalPadding,
        vertical: 20.r
      ),
      children: [
        Center(
          child: SlideTransition(
      position: _logoOffset,
      child: FadeTransition(
        opacity: _opacity,
        child: AppLogoWidget(),
      ),
    ),
        ),
        30.ph,
        ...widget.childrens,
       
      ],
    ),);
  }
}


