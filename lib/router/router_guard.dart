import 'package:auto_route/auto_route.dart';
import '/router/router.gr.dart';
import '../data/repositories/auth_repo.dart';

class RouteGuard extends AutoRedirectGuard {
  AuthRepository authService = AuthRepository();
  RouteGuard() {
    authService.addListener(() {
      if (!authService.authenticated) {
        reevaluate();
      }
    });
  }
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.authenticated) return resolver.next();
    router.push(
      LoginRoute(
        onLoginCallback: (_) {
          resolver.next();
          router.removeLast();
        },
      ),
    );
  }
}
