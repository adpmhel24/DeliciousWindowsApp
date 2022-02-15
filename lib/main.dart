import 'package:delicious_windows_app/router/router.gr.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router/router_guard.dart';

void main() => runApp(MainApp());

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
          fontFamily: GoogleFonts.merriweather().fontFamily,
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      ),
    );
  }
}
