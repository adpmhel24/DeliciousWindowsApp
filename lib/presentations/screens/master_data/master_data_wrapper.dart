import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MasterDataWrapperScreen extends StatefulWidget {
  const MasterDataWrapperScreen({Key? key}) : super(key: key);

  @override
  State<MasterDataWrapperScreen> createState() =>
      _MasterDataWrapperScreenState();
}

class _MasterDataWrapperScreenState extends State<MasterDataWrapperScreen> {
  // final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) {
    return const AutoRouter(
        // key: _innerRouterKey,
        );
  }
}
