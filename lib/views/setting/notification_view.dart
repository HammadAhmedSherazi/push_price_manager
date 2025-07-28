import 'package:push_price_manager/utils/extension.dart';
import '../../export_all.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final List notifications = List.generate(
      5,
      (index) =>  NotificationDataModel(
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
          
          
        },
        separatorBuilder: (context, indeex) => Divider(),
        itemCount: notifications.length,
      ),
    );
  }
}
