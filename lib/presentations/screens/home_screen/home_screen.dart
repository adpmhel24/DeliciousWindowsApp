import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Home'),
      ),
      content: Center(
        child: SizedBox(
          height: 200.h,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
