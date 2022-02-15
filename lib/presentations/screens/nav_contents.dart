import 'package:delicious_windows_app/presentations/screens/home_screen/home_screen.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/order_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';

NavigationBody navContent(index) {
  return NavigationBody(
    index: index,
    children: const [
      HomeScreen(),
      OrderScreen(),
    ],
  );
}
