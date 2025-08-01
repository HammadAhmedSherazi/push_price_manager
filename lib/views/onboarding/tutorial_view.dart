import 'package:push_price_manager/utils/extension.dart';
import '../../export_all.dart';

class TutorialView extends StatefulWidget {
  bool? isOnboarding;
  TutorialView({super.key, this.isOnboarding = true});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: widget.isOnboarding,
      bottomButtonText: "Next",
      onButtonTap: (){
        AppRouter.push(LoginView());
      },
      title: "Tutorial", child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: context.screenheight * 0.37,
            decoration: BoxDecoration(
              color: Color(0xff353535)
            ),
            child: Image.asset(Assets.tutorilaGif),
          ),
          Padding(padding: EdgeInsetsGeometry.all(20), child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit odio, mattis quam tortor taciti aenean luctus nullam enim, dui praesent ad dapibus tempus natoque a. Rh", textAlign: TextAlign.center ,style: context.textStyle.titleMedium ,),)
        ],
      ));
  }
}