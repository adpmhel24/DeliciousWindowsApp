import 'package:badges/badges.dart';
import 'package:delicious_windows_app/data/repositories/app_repo.dart';
import 'package:delicious_windows_app/data/repositories/orders_repo.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/orders_bloc/blocs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'components/for_dispatch_orders.dart';
import 'order_details/order_bloc/bloc.dart';
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

  DateTime startDate = DateTime.now().subtract(const Duration(days: 60));
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  int currentIndex = 0;

  final List<String> _appBarTitles = [
    "For Confirmation",
    "For Dispatch",
    "Delivered",
    "Canceled"
  ];

  @override
  Widget build(BuildContext context) {
    OrdersRepository _orderRepo = AppRepo.ordersReposistory;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrdersBloc()),
        BlocProvider(create: (context) => OrderBloc()),
      ],
      child: Builder(builder: (context) {
        return ScaffoldPage(
          header: PageHeader(
            title: Text(_appBarTitles[currentIndex]),
            commandBar: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 5.0,
                  children: [
                    SizedBox(
                      width: 295,
                      child: DatePicker(
                        header: 'Start Delivery Date',
                        headerStyle:
                            FluentTheme.of(context).typography.bodyLarge,
                        selected: startDate,
                        onChanged: (v) => setState(() => startDate = v),
                      ),
                    ),
                    SizedBox(
                      width: 295,
                      child: DatePicker(
                        header: 'End Delivery Date',
                        headerStyle:
                            FluentTheme.of(context).typography.bodyLarge,
                        selected: endDate,
                        onChanged: (v) => setState(() => endDate = v),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(FluentIcons.search),
                        onPressed: () {
                          if (currentIndex == 0) {
                            context.read<OrdersBloc>().add(
                                FetchForConfirmationOrders(startDate, endDate));
                          } else if (currentIndex == 1) {
                            context.read<OrdersBloc>().add(
                                FetchForDispatchOrders(startDate, endDate));
                          } else if (currentIndex == 2) {
                            context
                                .read<OrdersBloc>()
                                .add(FetchCompletedOrders(startDate, endDate));
                          } else {
                            context
                                .read<OrdersBloc>()
                                .add(FetchCanceledOrders(startDate, endDate));
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                  child: const Icon(FluentIcons.refresh),
                  onPressed: () {
                    gridKey.currentState!.refresh(false);
                    setState(() {
                      startDate =
                          DateTime.now().subtract(const Duration(days: 60));
                      endDate = DateTime.now().add(const Duration(days: 7));
                    });
                  },
                ),
              ],
            ),
          ),
          content: TabView(
            currentIndex: currentIndex,
            closeButtonVisibility: CloseButtonVisibilityMode.never,
            onChanged: (index) => setState(() => currentIndex = index),
            tabs: [
              Tab(
                icon: const Icon(FluentIcons.add_to_shopping_list),
                text: BlocBuilder<OrdersBloc, OrdersState>(
                  buildWhen: (previous, current) => current is OrdersLoaded,
                  builder: (context, state) {
                    return Badge(
                      badgeColor: Colors.teal.light,
                      stackFit: StackFit.expand,
                      badgeContent: Text(
                        "${_orderRepo.forConfirmationCount}",
                        style: const TextStyle(
                            fontSize: 11.0, color: Colors.white),
                      ),
                      child: const Text(
                        'For Confirmation',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      position: BadgePosition.topEnd(top: -4, end: 2),
                    );
                  },
                ),
              ),
              Tab(
                icon: const Icon(FluentIcons.delivery_truck),
                text: BlocBuilder<OrdersBloc, OrdersState>(
                  buildWhen: (previous, current) => current is OrdersLoaded,
                  builder: (context, state) {
                    return Badge(
                      badgeColor: Colors.teal.light,
                      badgeContent: Text(
                        "${_orderRepo.forDispatchCount}",
                        style: const TextStyle(
                            fontSize: 11.0, color: Colors.white),
                      ),
                      child: const Text(
                        'For Dispatch',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      position: BadgePosition.topEnd(top: -4, end: 2),
                    );
                  },
                ),
              ),
              const Tab(
                icon: Icon(FluentIcons.completed),
                text: Text(
                  'Completed',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              const Tab(
                icon: Icon(FluentIcons.warning),
                text: Text(
                  'Canceled',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],
            bodies: [
              ForConfirmation(
                gridKey: gridKey,
                startDate: startDate,
                endDate: endDate,
              ),
              ForDispatch(
                gridKey: gridKey,
                startDate: startDate,
                endDate: endDate,
              ),
              CompletedOrders(
                gridKey: gridKey,
                startDate: startDate,
                endDate: endDate,
              ),
              CanceledOrders(
                gridKey: gridKey,
                startDate: startDate,
                endDate: endDate,
              ),
            ],
          ),
        );
      }),
    );
  }
}
