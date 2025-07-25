import '../export_all.dart';

class UserProfileWidget extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final double? borderWidth;
  const UserProfileWidget({super.key, required this.radius , required this.imageUrl, this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: borderWidth ?? 5,
              color: AppColors.borderColor,
            ),
            color: AppColors.secondaryColor,
            
          ),
      child: CachedNetworkImage(imageUrl: imageUrl,imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      ), placeholder: (context, url) => CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(Assets.userAvatar),
      ), errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(Assets.userAvatar),
      ),),
    );
  }
}