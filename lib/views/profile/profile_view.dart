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
      body:  Consumer(builder: (context, ref, child){
        final response = ref.watch(authProvider.select((e)=>e.getStoresApiRes));
        return AsyncStateHandler(status: response.status, dataList: [1], itemBuilder: null, onRetry: (){
          ref.read(authProvider.notifier).getMyStores();
        }, customSuccessWidget: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          // alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
           
            SizedBox(
              height:context.screenheight * 0.19 ,
              child: CustomAppBarWidget(height: context.screenheight * 0.15, title: context.tr("profile"), children: [])),
            Positioned(
              top: 90.r,
              child: SizedBox(
                width: context.screenwidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final image = ref.watch(authProvider.select((e)=>e.staffInfo!.profileImage));
                        return UserProfileWidget(radius: 45.r, imageUrl:image,);
                      }
                    ),
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
                child: Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(authProvider.select((e)=>(e.staffInfo, e.stores)));
                    final user = data.$1!;
                    final stores = data.$2!;
                    return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(context.tr("personal_information"), style: context.textStyle.displayMedium,)
                        ],
                      ),
                      10.ph,
                        ProfileTitleWidget(
                          title: context.tr("name"),
                          value: user.fullName,
                        ),
                       ProfileTitleWidget(
                          title: context.tr("email_address"),
                          value: user.email,
                        ),
                        ProfileTitleWidget(
                          title: context.tr("phone_number"),
                          value: user.phoneNumber,
                        ),
                        ProfileTitleWidget(
                          title: AppConstant.userType == UserType.manager? context.tr("staff_id") : context.tr("employee_id"),
                          value: user.staffId.toString(),
                        ),
                        if(AppConstant.userType == UserType.manager)...[
                            10.ph,
                         Row(
                        children: [
                          Text(context.tr("assigned_stores"), style: context.textStyle.displayMedium,)
                        ],
                      ),
                      10.ph,
                     for(var i = 0; i<stores.length; i++)...[
                       ProfileTitleWidget(title: context.tr("store_branch_code_name"), value: stores[i].storeName),
                      ProfileTitleWidget(title: context.tr("store_address"), value: stores[i].storeLocation, showOutline: false,),
                      ProfileTitleWidget(title: context.tr("operational_hours"), value: stores[i].storeOperationalHours, showOutline: false,),
                      

                     ]
                      
                                 
                        ],
                        if(AppConstant.userType == UserType.employee)...[
                            ProfileTitleWidget(title: context.tr("store_branch_code_name"), value: stores.first.storeName),
                      ProfileTitleWidget(title: context.tr("store_address"), value: stores.first.storeLocation),
                      ProfileTitleWidget(title: context.tr("operational_hours"), value: stores.first.storeOperationalHours),
                    
                    
                        ]
                            
                    ],
                              );
                  }
                ),
              )),
              // Positioned(
              // top: 160.r,
              // right: 10.r,
              // child: IconButton(
              //   onPressed: (){
              //   AppRouter.push(CreateProfileView(isEdit: true,));
              // }, icon: Icon(Icons.edit, color: AppColors.secondaryColor,))),
          ],
        ),
      ),
   );
      }) );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool showOutline;
  const ProfileTitleWidget({
    super.key,
    required this.title,
    required this.value,
    this.showOutline = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(
        bottom: 10.r
      ),
      padding: EdgeInsets.only(
        bottom: 10.r,
        left: !showOutline ? 10.r: 0.0
      ),
      decoration: showOutline? BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor
          )
        )
      ) : null,
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