import '../export_all.dart';

class UserProfileWidget extends StatelessWidget {
  final num radius;
  final String? imageUrl;
  final double? borderWidth;

  const UserProfileWidget({
    super.key,
    required this.radius,
    this.imageUrl,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final avatarRadius = radius.iw;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: borderWidth ?? 5,
          color: AppColors.borderColor,
        ),
        color: AppColors.secondaryColor,
      ),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: avatarRadius,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const AssetImage(Assets.userAvatar),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const AssetImage(Assets.userAvatar),
              ),
            )
          : CircleAvatar(
              radius: avatarRadius,
              backgroundImage: const AssetImage(Assets.userAvatar),
            ),
    );
  }
}
