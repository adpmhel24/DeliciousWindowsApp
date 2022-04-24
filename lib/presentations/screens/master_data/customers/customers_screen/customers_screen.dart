import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/customers_body.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      padding: EdgeInsets.only(top: 5.h, right: 10.w, bottom: 20.h, left: 10.w),
      header: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () {
              AutoRouter.of(context).pop();
            }),
      ),
      content: const Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: CustomersBody(),
      ),
    );
  }
}
