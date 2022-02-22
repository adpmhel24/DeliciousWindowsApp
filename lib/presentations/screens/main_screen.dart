import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_bloc/auth_bloc/bloc.dart';
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

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.activate_orders),
      title: const Text('Orders'),
      tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
      // infoBadge: const InfoBadge(
      //   source: Text('9'),
      // ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.money),
      title: const Text('Payment'),
      tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
    ),
  ];

  final List<NavigationPaneItem> _footerItems = [
    PaneItem(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Profile'),
      tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      tileColor: ButtonState.all(const Color(0xFFBFFFF0)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        automaticallyImplyLeading: false,
        // actions: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(children: []),
        // ),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        selected: index,
        onChanged: (i) {
          var length = _items.length + _footerItems.length;
          if (i < length) {
            setState(() => index = i);
          }
        },
        items: _items,
        footerItems: [
          PaneItemSeparator(),
          ..._footerItems,
          _LinkPaneItemAction(
              icon: const Icon(FluentIcons.sign_out),
              pressed: () {
                context.read<AuthBloc>().add(LoggedOut());
              })
        ],
      ),
      content: navContent(index),
    );
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction(
      {required Widget icon,
      title,
      infoBadge,
      focusNode,
      autofocus = false,
      this.pressed})
      : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );

  void Function()? pressed;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: pressed, icon: const Icon(FluentIcons.sign_out)),
      ),
    );
  }
}
