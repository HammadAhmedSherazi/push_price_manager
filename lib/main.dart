import 'export_all.dart';


void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          navigatorKey: AppRouter.navKey,
    //       localizationsDelegates: [

    //    GlobalMaterialLocalizations.delegate,

    //    GlobalWidgetsLocalizations.delegate,

    //    GlobalCupertinoLocalizations.delegate,

    //  ],
     supportedLocales: [

       const Locale('en', ""), // English

       const Locale('es', ""), // Spanish

       // Add more languages here

     ],

     locale: Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Push Price',
          theme: AppTheme.lightTheme,
          home: child,
        );
      },
      useInheritedMediaQuery: true,
      child: OnboardingView(),
    );
  }
}
