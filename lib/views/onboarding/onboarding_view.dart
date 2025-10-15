import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _logoOffset;
  late Animation<Offset> _imageOffset;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // _logoOffset = Tween<Offset>(
    //   begin: const Offset(0, -0.5),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // _imageOffset = Tween<Offset>(
    //   begin: const Offset(0, 0.5),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // _opacity = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    // );
  _logoOffset = Tween<Offset>(
  begin: const Offset(-1.0, 0.0), // From left
  end: Offset.zero,
).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

_imageOffset = Tween<Offset>(
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
    return Scaffold(
      
      body: Container(
        padding:  EdgeInsets.fromLTRB(AppTheme.horizontalPadding, 50.r, AppTheme.horizontalPadding, 10.r),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
      position: _logoOffset,
      child: FadeTransition(
        opacity: _opacity,
        child: AppLogoWidget(),
      ),
    ),
    SlideTransition(
      position: _imageOffset,
      child: FadeTransition(
        opacity: _opacity,
        child: Image.asset(
          Assets.onBoardingImage,
          width: double.infinity,
          height: 285.r,
          fit: BoxFit.cover,
        ),
      ),
    ), 
    SlideTransition(position: _imageOffset, child: FadeTransition(opacity: _opacity, child: RichText(
              textAlign: TextAlign.center,
  text: TextSpan(
    
    style: context.textStyle.displayMedium!.copyWith(
      fontSize: 32.sp,
      
    ),
    
    children: [
      TextSpan(text: "Let’s Find The "),
      TextSpan(
        text: "Best",
        style: context.textStyle.displayMedium!.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 32.sp,
      
    ),
      ),
      TextSpan(text: " & "),
      TextSpan(
        text: "Healthy Grocery",
        style: context.textStyle.displayMedium!.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 32.sp,
      
    ),
      ),
     
    ],
  ),
),),),
SlideTransition(position: _imageOffset, child: FadeTransition(opacity: _opacity, child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit odio, mattis quam tortor taciti aenean luctus nullam enim, dui praesent ad dapibus tempus natoque.", style: context.textStyle.titleMedium, textAlign: TextAlign.center,),
           
),),
             Spacer(),
            CustomButtonWidget(title: context.tr("get_started"), onPressed: (){
              AppRouter.pushReplacement(SelectLanguageView());
            })

          ],
        ),
      ) ,
    );
  }
}