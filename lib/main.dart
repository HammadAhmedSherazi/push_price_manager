import 'dart:convert';
import 'dart:io';
import 'export_all.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Pure routing: no [WidgetRef], no callbacks, no side effects — safe to call from [build].
Widget initialHomeFromPrefs(SharedPreferenceManager prefs) {
  final token = prefs.getToken();
  final hasValidToken = token != null && token.isNotEmpty;
  if (hasValidToken) {
    return const NavigationView();
  }
  if (prefs.getStartedCheck()) return const LoginView();
  return const OnboardingView();
}

/// Ensures [AppConstant.userType] matches prefs before [NavigationView] builds (first frame).
void syncUserTypeFromPrefs(SharedPreferenceManager prefs) {
  final raw = prefs.getUserData();
  if (raw == null || raw.isEmpty) return;
  try {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final role = map['role_type'] as String? ?? '';
    AppConstant.userType =
        role == 'EMPLOYEE' ? UserType.employee : UserType.manager;
  } catch (_) {
    AppConstant.userType = UserType.manager;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceManager.init();
  await ScreenUtil.ensureScreenSize();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  static const _coldStartResumeSkip = Duration(seconds: 1);
  static const _resumeRestoreThrottle = Duration(seconds: 2);

  late final DateTime _appStartedAt;
  bool _initialSessionRestoreScheduled = false;
  DateTime? _lastResumeRestoreAt;

  @override
  void initState() {
    super.initState();
    _appStartedAt = DateTime.now();
    WidgetsBinding.instance.addObserver(this);

    final prefs = SharedPreferenceManager.sharedInstance;
    final token = prefs.getToken();
    if (token != null && token.isNotEmpty) {
      syncUserTypeFromPrefs(prefs);
      _scheduleInitialSessionRestoreOnce();
    }
  }

  /// Single post-frame restore on cold start — not tied to [build] rebuilds.
  void _scheduleInitialSessionRestoreOnce() {
    if (_initialSessionRestoreScheduled) return;
    _initialSessionRestoreScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(authProvider.notifier).restoreUserFromCache();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (!mounted) return;

    // Avoid overlapping with the first-frame restore right after launch.
    if (DateTime.now().difference(_appStartedAt) < _coldStartResumeSkip) {
      return;
    }

    final prefs = SharedPreferenceManager.sharedInstance;
    final token = prefs.getToken();
    if (token == null || token.isEmpty) return;

    final now = DateTime.now();
    if (_lastResumeRestoreAt != null &&
        now.difference(_lastResumeRestoreAt!) < _resumeRestoreThrottle) {
      return;
    }
    _lastResumeRestoreAt = now;

    syncUserTypeFromPrefs(prefs);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(authProvider.notifier).restoreUserFromCache();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);
    final prefs = SharedPreferenceManager.sharedInstance;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final hasSystemBottomInset =
            (MediaQuery.maybeOf(context)?.viewPadding.bottom ?? 0) > 0;
        return Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            bottom: Platform.isAndroid ? hasSystemBottomInset : false,
            child: MaterialApp(
              navigatorKey: AppRouter.navKey,
              localizationsDelegates: const [
                LocalizationService.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('es', ''),
              ],
              locale: currentLocale,
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
      child: initialHomeFromPrefs(prefs),
    );
  }
}
