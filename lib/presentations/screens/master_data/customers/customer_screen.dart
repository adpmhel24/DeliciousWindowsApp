import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () {
              AutoRouter.of(context).pop();
            }),
      ),
      content: const Center(
        child: Text("Customers"),
      ),
    );
  }
}
