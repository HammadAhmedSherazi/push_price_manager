import '../export_all.dart';

abstract class AppColors {
  static const primaryColor = Color(0xff0B7BD2);
  static const secondaryColor = Color(0xff008B83);
  static const primaryAppBarColor = Color.fromRGBO(230, 243, 253, 0.5);

  static const primaryTextColor = Color(0xff2F2F2F);

  static const disableButtonColor = Color.fromRGBO(209, 213, 230, 1);
  static const borderColor = Color(0xffC4D1D0);

  static const primaryGradient = LinearGradient(
              begin: Alignment(-0.25, -1.0), // Adjust to match 157deg
              end: Alignment(1.0, 0.5), // Adjust end position
              colors: [
                Color(0xFF02243F), // #02243F at 41.72%
                Color(0xFF072B48), // #072B48 at 56.48%
                Color(0xFF1F4F74), // #1F4F74 at 91.09%
              ],
              stops: [0.4172, 0.5648, 0.9109], // Positions in gradient
            );
  
  static const secondaryGradient = RadialGradient(
              center: Alignment.center, // 50% 50%
              radius: 0.812, // 81.2% of the shortest side
              colors: [
                Color(0xFFCFD4EA), // #CFD4EA at 0%
                Color(0xFFE8EBF6), // #E8EBF6 at 100%
              ],
              stops: [0.0, 1.0], // Define color stop positions
            )
          ;
          
  
}