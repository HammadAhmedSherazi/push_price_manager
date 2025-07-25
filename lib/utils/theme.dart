

import '../export_all.dart';



class AppTheme {

  AppTheme._();
  static final ThemeData darkTheme = ThemeData(
    fontFamily: "Roboto",
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: darkColorScheme,
    bottomNavigationBarTheme: bottomNavigationBarDakTheme,
    inputDecorationTheme: inputDecorationDarkTheme,
    scaffoldBackgroundColor: Colors.white,
    switchTheme: SwitchThemeData(
 
 
).copyWith(
   thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return AppColors.secondaryColor; // Thumb color when switch is ON
    }
    return Colors.white; // Thumb color when switch is OFF
  }),
),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0.0),
      side: const WidgetStatePropertyAll(
          BorderSide(color: Colors.white, width: 1)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
          side: const BorderSide(color: Colors.white, width: 1))),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
    )),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.56),
      bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.56),
      bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.56),
      displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.96),
      displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.96),
      displaySmall: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.96),
      headlineLarge: TextStyle(
          color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w900),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w900),
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w900),
      labelLarge: TextStyle(
          color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w300),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w300),
      titleSmall: TextStyle(
          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w300),
    ),
    // Add other theme properties as needed
  );

  static final ThemeData lightTheme = ThemeData(
      fontFamily: "Roboto",
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      colorScheme: lightColorScheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        clipBehavior: Clip.none
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: bottomNavigationBarLightTheme,
      inputDecorationTheme: inputDecorationLightTheme,
      
      switchTheme: SwitchThemeData(
 
 
).copyWith(
   thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return AppColors.secondaryColor; // Thumb color when switch is ON
    }
    return Colors.white; // Thumb color when switch is OFF
  }),
),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0.0),
        side: const WidgetStatePropertyAll(
            BorderSide(color: Colors.black, width: 1)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
            side: const BorderSide(color: Colors.black, width: 1))),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.black),
      )),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.56),
        bodyMedium: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.56),
        bodySmall: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.56),
        displayLarge: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.96),
        displayMedium: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.96),
        displaySmall: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.96),
        headlineLarge: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 24.sp, fontWeight: FontWeight.w900),
        headlineMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w900),
        headlineSmall: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 12.sp, fontWeight: FontWeight.w900),
        labelLarge: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 24.sp, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 24.sp, fontWeight: FontWeight.w300),
        titleMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w300),
        titleSmall: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 12.sp, fontWeight: FontWeight.w300),
      ));

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: Color(0xffEFEDEC),
    onSecondary: Color(0xFF2F2F2F),
    surface: Color(0xFF2F2F2F),
    onSurface: Colors.black,
    primaryContainer: Colors.black,
    secondaryContainer: AppColors.secondaryColor,
    inversePrimary: Color(0xffEFEDEC),
    inverseSurface: Colors.white,
    onInverseSurface: Color(0xFF515151),
    onSurfaceVariant: Color(0xFF121212),
    error: Colors.red,
    onError: Colors.white,
  );

  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: Color(0xffEFEDEC),
    onSecondary: Colors.white,
    surface:Colors.white ,
    onSurface: Colors.black,
    primaryContainer: Colors.white,
    secondaryContainer: AppColors.secondaryColor,
    inversePrimary: Colors.black,
    inverseSurface: Colors.black,
    onInverseSurface: Color(0xffEFEFEF),
    onSurfaceVariant: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  );

  static BottomNavigationBarThemeData bottomNavigationBarLightTheme =
      BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
          selectedLabelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600));

  static BottomNavigationBarThemeData bottomNavigationBarDakTheme =
      BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
          selectedLabelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal));
  static InputDecorationTheme inputDecorationLightTheme = InputDecorationTheme(
    // hintStyle: lightTheme.textTheme.bodyLarge!
    //     .copyWith(fontSize: 16.sp, color: Colors.black.withValues(0.3)),
    errorMaxLines: 3,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: Colors.transparent,
    labelStyle: TextStyle().copyWith(
      color: AppColors.primaryTextColor
    ),
    hintStyle: TextStyle(
        fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w400),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(4.r),),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(4.r),),
    border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(4.r),),
  );
  static InputDecorationTheme inputDecorationDarkTheme = InputDecorationTheme(
    // hintStyle: lightTheme.textTheme.bodyLarge!
    //     .copyWith(fontSize: 16.sp, color: Colors.black.withValues(0.3)),
    errorMaxLines: 3,
    hintStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.white.withValues(alpha: 0.3),
        fontWeight: FontWeight.w400),
  floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.white, width: 1)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.white, width: 1)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.white, width: 1)),
  );

  static double get horizontalPadding => 20.r;

  static BoxDecoration boxDecoration =  BoxDecoration(
            color: Color.fromRGBO(251, 251, 251, 1),
            border: Border.all(
              color: AppColors.borderColor
            ),
            borderRadius: BorderRadius.circular(8.r)
          );
  static BoxDecoration productBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
       color: Color.fromRGBO(243, 243, 243, 1)
  );
}
