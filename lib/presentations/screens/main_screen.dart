import 'package:fluent_ui/fluent_ui.dart';

import 'nav_contents.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final settingsController = ScrollController();

  @override
  void dispose() {
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        selected: index,
        onChanged: (i) => setState(() => index = i),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.activate_orders),
            title: const Text('Orders'),
            tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.money),
            title: const Text('Sales'),
            tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
          ),
        ],
      ),
      content: navContent(index),
    );
  }
}
