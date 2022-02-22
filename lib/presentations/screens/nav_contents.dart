import 'package:fluent_ui/fluent_ui.dart';

import 'home_screen/home_screen.dart';
import 'orders_screen/order_screen.dart';
import 'payment_screen/payment_screen.dart';
import 'profile_screen/profile_screen.dart';
import 'settings_screen/settings_screen.dart';

NavigationBody navContent(index) {
  return NavigationBody(
    index: index,
    children: const [
      HomeScreen(),
      OrderScreen(),
      PaymentScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ],
  );
}
