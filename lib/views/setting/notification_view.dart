import 'package:push_price_manager/utils/extension.dart';
import '../../export_all.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final List notifications = List.generate(
      5,
      (index) => index == 0?StoreProductNotification(title: "ABC product is available now!", storeName: "Abc Store", storeAddress: "Abc Address") : NotificationDataModel(
        title: "Lorem ipsum",
        description: "Lorem ipsum dolor sit amet consectetur.",
        count: 1,
      ),
    );
    return CustomScreenTemplate(
      title: "Notifications",
      child: ListView.separated(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        itemBuilder: (context, index) {
          if(index ==0 ){
            final StoreProductNotification noti = notifications[index];
            return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0
          ),
          leading: Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Colors.white.withValues(alpha: 0.5)
              ),
              color: AppColors.secondaryColor
            ),
            child: SvgPicture.asset(Assets.notificationWhiteIcon),
          ),
          title: Text(noti.title, style: context.textStyle.displayMedium!.copyWith(
            color: AppColors.secondaryColor,
            height: 1.0,
            fontSize: 16.sp
         
          ), ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text("${noti.storeName}\n${noti.storeAddress}", style: context.textStyle.displayMedium!.copyWith(
                  color: Color(0xff5B5B5B)
                ),),
                
              ),
              GestureDetector(
                onTap: (){
                  AppRouter.push(StoreView());
                },
                child: Container(
                  height: 35.h,
                  // width: 90.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.r
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.primaryColor
                  ),
                  child: Text("Visit Store", style: context.textStyle.displayMedium!.copyWith(
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        
        );
          }
          else{
            final notification = notifications[index];
          return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0
          ),
          leading: Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Colors.white.withValues(alpha: 0.5)
              ),
              color: AppColors.secondaryColor
            ),
            child: SvgPicture.asset(Assets.notificationWhiteIcon),
          ),
          title: Text(notification.title, style: context.textStyle.displayMedium!.copyWith(
            color: AppColors.secondaryColor,
            
            fontSize: 16.sp
         
          ), ),
          subtitle: Text(notification.description, style: context.textStyle.displayMedium!.copyWith(
            color: Color(0xff5B5B5B)
          ),),
          trailing: Column(
            children: [
              Container(
            width: 20.r,
            height: 20.r,
            alignment: Alignment.center,
           
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Colors.white.withValues(alpha: 0.5)
              ),
              color: AppColors.secondaryColor
            ),
            child: Text(notification.count.toString(), style: context.textStyle.bodySmall!.copyWith(
              color: Colors.white
            ),),
          )
            ],
          ),
        );
          }
          
        },
        separatorBuilder: (context, indeex) => Divider(),
        itemCount: notifications.length,
      ),
    );
  }
}
