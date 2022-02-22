import 'package:fluent_ui/fluent_ui.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text('Payment'),
      ),
      content: Center(child: Text("Under Development")),
    );
  }
}
