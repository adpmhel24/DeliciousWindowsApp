import 'package:auto_route/auto_route.dart';
import 'package:delicious_windows_app/presentations/screens/home_screen/home_screen.dart';

import '../presentations/screens/orders_screen/order_screen.dart';
import '../presentations/screens/login_screen/login_screen.dart';
import 'router_guard.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: LoginScreen, name: 'LoginRoute', path: '/login'),
  AutoRoute(page: HomeScreen, path: '/', guards: [RouteGuard]),
  AutoRoute(page: OrderScreen, path: '/orderScreen', guards: [RouteGuard]),
])
class $AppRouter {}
