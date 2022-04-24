import 'package:auto_route/auto_route.dart';
import '../presentations/screens/home_screen/home_screen.dart';
import '../presentations/screens/master_data/customers/customers_screen/customers_screen.dart';
import '../presentations/screens/master_data/master_data_home.dart';

import '../presentations/screens/main_screen.dart';
import '../presentations/screens/orders_screen/order_screen.dart';
import '../presentations/screens/login_screen/login_screen.dart';
import '../presentations/screens/master_data/master_data_wrapper.dart';

import '../presentations/screens/payment_screen/payment_screen.dart';
import 'router_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, name: 'LoginRoute', path: '/login'),
    AutoRoute(
      page: MainScreen,
      path: '/',
      guards: [RouteGuard],
      children: [
        AutoRoute(page: HomeScreen, path: ''),
        AutoRoute(page: OrderScreen, path: 'orders'),
        AutoRoute(page: PaymentScreen, path: 'payment'),
        masterDataRoute,
      ],
    ),
  ],
)
class $AppRouter {}

const masterDataRoute = AutoRoute(
  name: 'MasterDataRouter',
  path: 'masterData',
  page: MasterDataWrapperScreen,
  guards: [RouteGuard],
  children: [
    AutoRoute(path: '', page: MasterDataHomeScreen),
    AutoRoute(path: 'customers', page: CustomersScreen),
  ],
);
