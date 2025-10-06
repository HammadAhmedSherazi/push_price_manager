import 'export_all.dart';


void main() async {
  await ScreenUtil.ensureScreenSize();
  SharedPreferenceManager.init();
   runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
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
        return Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom
          ),
            child: MaterialApp(
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
              title: 'Push Price Store',
              theme: AppTheme.lightTheme,
               builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child!,
                );
              },
              home: child,
            ),
          ),
        );
      },
      useInheritedMediaQuery: true,
      child: OnboardingView(),
    );
  }
}
