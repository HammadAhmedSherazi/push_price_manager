import '../export_all.dart';

class CustomBackWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final num? width;
  final num? height;

  static const double defaultSize = 40;

  const CustomBackWidget({super.key, this.onTap, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final boxSize = (width ?? defaultSize).iw;

    return GestureDetector(
      onTap: onTap ?? () => AppRouter.back(),
      child: Container(
        width: boxSize,
        height: (height ?? defaultSize).ih,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.iw),
          color: const Color(0xffEBF5FC),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.secondaryColor,
          size: boxSize * 0.45,
        ),
      ),
    );
  }
}
