import '../export_all.dart';

class CustomBackWidget extends StatelessWidget {
  final VoidCallback ? onTap;
  final double? width,height;
  const CustomBackWidget({super.key, this.onTap, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){
        AppRouter.back();
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: 6.r,
          
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Color(0xffEBF5FC)
        ),
        child: Icon(Icons.arrow_back_ios, color: AppColors.secondaryColor, size: 16.r,),
      ),
    );
  }
}