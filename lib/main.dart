import 'package:delicious_windows_app/router/router.gr.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  // Use it only after calling `hiddenWindowAtLaunch`
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(1024, 640));
    await windowManager.center();
    await windowManager.show();
  });
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(routeGuard: RouteGuard());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 640),
      minTextAdapt: true,
      builder: () => FluentApp.router(
        color: Colors.transparent,
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        theme: ThemeData(
          // fontFamily: GoogleFonts.merriweather().fontFamily,
          typography: const Typography(
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 75, 48, 48),
            ),
            title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 75, 48, 48),
            ),
            body: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate, // This is required
        ],
      ),
    );
  }
}
