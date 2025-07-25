import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class SelectUserView extends StatelessWidget {
  const SelectUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(title: "Select User", child: Container(
      width: context.screenwidth,
      height: context.screenheight,
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.horizontalPadding
      ),
      child: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonWidget(title: "employee", onPressed: (){
            AppConstant.userType = UserType.employee;
            AppRouter.push(TutorialView());
          }),
          CustomButtonWidget(title: "manager", onPressed: (){
            AppConstant.userType = UserType.manager;
            AppRouter.push(TutorialView());

          }, color: AppColors.secondaryColor,),
        ],
      ),
    ));
  }
}