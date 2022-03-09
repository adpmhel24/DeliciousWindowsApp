// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:fluent_ui/fluent_ui.dart' as _i12;
import 'package:flutter/material.dart' as _i10;

import '../presentations/screens/home_screen/home_screen.dart' as _i3;
import '../presentations/screens/login_screen/login_screen.dart' as _i1;
import '../presentations/screens/main_screen.dart' as _i2;
import '../presentations/screens/master_data/customers/customer_screen.dart'
    as _i8;
import '../presentations/screens/master_data/master_data_home.dart' as _i7;
import '../presentations/screens/master_data/master_data_wrapper.dart' as _i6;
import '../presentations/screens/orders_screen/order_screen.dart' as _i4;
import '../presentations/screens/payment_screen/payment_screen.dart' as _i5;
import 'router_guard.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter(
      {_i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i11.RouteGuard routeGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    MainScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.MainScreen());
    },
    HomeScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    OrderScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OrderScreen());
    },
    PaymentScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PaymentScreen());
    },
    MasterDataRouter.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MasterDataWrapperScreen());
    },
    MasterDataHomeScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.MasterDataHomeScreen());
    },
    CustomersScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CustomersScreen());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(LoginRoute.name, path: '/login'),
        _i9.RouteConfig(MainScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i9.RouteConfig(HomeScreenRoute.name,
              path: '', parent: MainScreenRoute.name),
          _i9.RouteConfig(OrderScreenRoute.name,
              path: 'orders', parent: MainScreenRoute.name),
          _i9.RouteConfig(PaymentScreenRoute.name,
              path: 'payment', parent: MainScreenRoute.name),
          _i9.RouteConfig(MasterDataRouter.name,
              path: 'masterData',
              parent: MainScreenRoute.name,
              guards: [
                routeGuard
              ],
              children: [
                _i9.RouteConfig(MasterDataHomeScreenRoute.name,
                    path: '', parent: MasterDataRouter.name),
                _i9.RouteConfig(CustomersScreenRoute.name,
                    path: 'customers', parent: MasterDataRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i12.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i12.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.MainScreen]
class MainScreenRoute extends _i9.PageRouteInfo<void> {
  const MainScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(MainScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeScreenRoute extends _i9.PageRouteInfo<void> {
  const HomeScreenRoute() : super(HomeScreenRoute.name, path: '');

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i4.OrderScreen]
class OrderScreenRoute extends _i9.PageRouteInfo<void> {
  const OrderScreenRoute() : super(OrderScreenRoute.name, path: 'orders');

  static const String name = 'OrderScreenRoute';
}

/// generated route for
/// [_i5.PaymentScreen]
class PaymentScreenRoute extends _i9.PageRouteInfo<void> {
  const PaymentScreenRoute() : super(PaymentScreenRoute.name, path: 'payment');

  static const String name = 'PaymentScreenRoute';
}

/// generated route for
/// [_i6.MasterDataWrapperScreen]
class MasterDataRouter extends _i9.PageRouteInfo<void> {
  const MasterDataRouter({List<_i9.PageRouteInfo>? children})
      : super(MasterDataRouter.name,
            path: 'masterData', initialChildren: children);

  static const String name = 'MasterDataRouter';
}

/// generated route for
/// [_i7.MasterDataHomeScreen]
class MasterDataHomeScreenRoute extends _i9.PageRouteInfo<void> {
  const MasterDataHomeScreenRoute()
      : super(MasterDataHomeScreenRoute.name, path: '');

  static const String name = 'MasterDataHomeScreenRoute';
}

/// generated route for
/// [_i8.CustomersScreen]
class CustomersScreenRoute extends _i9.PageRouteInfo<void> {
  const CustomersScreenRoute()
      : super(CustomersScreenRoute.name, path: 'customers');

  static const String name = 'CustomersScreenRoute';
}
