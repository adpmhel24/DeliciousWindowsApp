import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForConfirmDetails extends StatefulWidget {
  const ForConfirmDetails({Key? key}) : super(key: key);

  @override
  State<ForConfirmDetails> createState() => _ForConfirmDetailsState();
}

class _ForConfirmDetailsState extends State<ForConfirmDetails> {
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    _idController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    textDirection: TextDirection.ltr,
                    children: const [
                      Text('Order ID: '),
                      Text('1'),
                    ],
                  ),
                  Wrap(
                    children: const [
                      Text('Transaction Date: '),
                      Text('02/20/2022'),
                    ],
                  ),
                  Wrap(
                    children: const [
                      Text('Delivery Date: '),
                      Text('02/20/2022'),
                    ],
                  ),
                  Wrap(
                    children: const [
                      Text('Customer Code: '),
                      Text('Romel Catalogo'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            Flexible(
              child: Column(
                children: [
                  TextBox(
                    enabled: false,
                    controller: TextEditingController(text: '1'),
                    prefix: const Text("Order Id:"),
                  ),
                  TextBox(
                    enabled: false,
                    controller: TextEditingController(text: '1'),
                    prefix: const Text("Order Id:"),
                  )
                ],
              ),
            ),
          ],
        ),
        TextBox(
          enabled: false,
          controller: TextEditingController(text: '1'),
          prefix: const Text("Order Id:"),
        ),
      ],
    );
  }
}
