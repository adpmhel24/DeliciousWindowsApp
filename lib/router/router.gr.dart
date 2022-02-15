// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:fluent_ui/fluent_ui.dart' as _i7;
import 'package:flutter/material.dart' as _i5;

import '../presentations/screens/login_screen/login_screen.dart' as _i1;
import '../presentations/screens/main_screen.dart' as _i2;
import '../presentations/screens/orders_screen/order_screen.dart' as _i3;
import 'router_guard.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i6.RouteGuard routeGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    MainScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.MainScreen());
    },
    OrderScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OrderScreen());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(LoginRoute.name, path: '/login'),
        _i4.RouteConfig(MainScreenRoute.name, path: '/', guards: [routeGuard]),
        _i4.RouteConfig(OrderScreenRoute.name,
            path: '/orderScreen', guards: [routeGuard])
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i7.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i7.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.MainScreen]
class MainScreenRoute extends _i4.PageRouteInfo<void> {
  const MainScreenRoute() : super(MainScreenRoute.name, path: '/');

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i3.OrderScreen]
class OrderScreenRoute extends _i4.PageRouteInfo<void> {
  const OrderScreenRoute() : super(OrderScreenRoute.name, path: '/orderScreen');

  static const String name = 'OrderScreenRoute';
}
