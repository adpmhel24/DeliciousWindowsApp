import 'package:fluent_ui/fluent_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text('Settings'),
      ),
      content: Center(child: Text("Under Development")),
    );
  }
}
