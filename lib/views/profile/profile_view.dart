import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({super.key, });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          // alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
           
            SizedBox(
              height:context.screenheight * 0.19 ,
              child: CustomAppBarWidget(height: context.screenheight * 0.15, title: "Profile", children: [])),
            Positioned(
              top: 90.r,
              child: SizedBox(
                width: context.screenwidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileWidget(radius: 45.r, imageUrl:  Assets.userImage ,),
                  ],
                ),
              )),
            
            Positioned(
              top: 200.h,
              child: Container(
                width: context.screenwidth,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.horizontalPadding
                ),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    ProfileTitleWidget(
                      title: "Name",
                      value: "John Smith",
                    ),
                    ProfileTitleWidget(
                      title: "Address",
                      value: "Abc street, Lorem Ipsum",
                    ),
                    ProfileTitleWidget(
                      title: "Phone Number",
                      value: "00000000",
                    ),
                    ProfileTitleWidget(
                      title: "Email Address",
                      value: "Abc@domain.com",
                    ),
                   
                ],
                          ),
              )),
              Positioned(
              top: 160.r,
              right: 10.r,
              child: IconButton(
                onPressed: (){
                AppRouter.push(CreateProfileView(isEdit: true,));
              }, icon: Icon(Icons.edit, color: AppColors.secondaryColor,))),
          ],
        ),
      ),
    );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProfileTitleWidget({
    super.key,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(
        bottom: 10.r
      ),
      padding: EdgeInsets.only(
        bottom: 10.r
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor
          )
        )
      ),
      child: Row(
        children: [
          Text(title, style: context.textStyle.bodyMedium,),
          Expanded(child: Text(value, 
          textAlign: TextAlign.end,
          style: context.textStyle.displayMedium,))
        ],
      ),
    );
  }
}