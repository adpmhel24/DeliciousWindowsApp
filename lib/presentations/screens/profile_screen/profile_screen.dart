import 'package:fluent_ui/fluent_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text('Profile'),
      ),
      content: Center(child: Text("Under Development")),
    );
  }
}
