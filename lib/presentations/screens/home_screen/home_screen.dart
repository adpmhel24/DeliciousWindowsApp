import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text('Home'),
      ),
      content: Center(child: Text("Under Development")),
    );
  }
}
