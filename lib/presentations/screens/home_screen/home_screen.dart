import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text("Home"),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.auto,
      ),
    );
  }
}
