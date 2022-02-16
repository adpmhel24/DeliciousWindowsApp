import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'components/for_dispatch_orders.dart';
import 'orders_bloc/orders_bloc.dart';
import './components/canceled_orders.dart';
import './components/completed_orders.dart';
import './components/for_confirmation_orders.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(),
      child: ScaffoldPage(
        header: PageHeader(
          title: const Text('Orders'),
          commandBar: Column(children: [
            Button(
                child: const Icon(FluentIcons.refresh),
                onPressed: () {
                  gridKey.currentState!.refresh(false);
                }),
          ]),
        ),
        content: Builder(builder: (_) {
          return TabView(
            currentIndex: currentIndex,
            closeButtonVisibility: CloseButtonVisibilityMode.never,
            onChanged: (index) => setState(() => currentIndex = index),
            tabs: const [
              Tab(
                icon: Icon(FluentIcons.add_to_shopping_list),
                text: Text('For Confirmation'),
              ),
              Tab(
                icon: Icon(FluentIcons.delivery_truck),
                text: Text('For Dispatch'),
              ),
              Tab(
                icon: Icon(FluentIcons.completed),
                text: Text('Completed'),
              ),
              Tab(
                icon: Icon(FluentIcons.warning),
                text: Text('Canceled'),
              ),
            ],
            bodies: [
              ForConfirmation(gridKey: gridKey),
              ForDispatch(gridKey: gridKey),
              CompletedOrders(gridKey: gridKey),
              CanceledOrders(gridKey: gridKey),
            ],
          );
        }),
      ),
    );
  }
}
