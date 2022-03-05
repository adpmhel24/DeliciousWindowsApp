import 'package:badges/badges.dart';
import '/presentations/screens/orders_screen/orders_bloc/blocs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data/repositories/repositories.dart';
import 'components/for_dispatch_orders.dart';
import 'order_comment_bloc/bloc.dart';
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

  DateTime startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime endDate = DateTime.now().add(const Duration(days: 30));

  int currentIndex = 0;

  final List<Map<String, dynamic>> _appBarTitles = [
    {"name": "For Confirmation", "color": Colors.green.light},
    {"name": "For Dispatch", "color": Colors.orange.light},
    {"name": "Completed", "color": Colors.grey},
    {"name": "Canceled", "color": Colors.red.light}
  ];

  @override
  Widget build(BuildContext context) {
    OrdersRepository _orderRepo = AppRepo.ordersReposistory;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrdersBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => OrderCommentBloc()),
      ],
      child: ChangeNotifierProvider<OrderRepository>(
        create: (context) => OrderRepository(),
        child: Builder(builder: (context) {
          return ScaffoldPage(
            header: PageHeader(
              title: Text(
                _appBarTitles[currentIndex]["name"],
                style: TextStyle(color: _appBarTitles[currentIndex]["color"]),
              ),
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
                                  FetchForConfirmationOrders(
                                      startDate, endDate));
                            } else if (currentIndex == 1) {
                              context.read<OrdersBloc>().add(
                                  FetchForDispatchOrders(startDate, endDate));
                            } else if (currentIndex == 2) {
                              context.read<OrdersBloc>().add(
                                  FetchCompletedOrders(startDate, endDate));
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
                      setState(() {
                        startDate =
                            DateTime.now().subtract(const Duration(days: 14));
                        endDate = DateTime.now().add(const Duration(days: 30));
                      });
                      gridKey.currentState!.refresh(false);
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
                  text: Container(
                    color: (currentIndex == 0) ? const Color(0xFFC1F8CF) : null,
                    child: BlocBuilder<OrdersBloc, OrdersState>(
                      buildWhen: (previous, current) => current is OrdersLoaded,
                      builder: (context, state) {
                        return Badge(
                          badgeColor: Colors.teal.light,
                          position: BadgePosition.topStart(),
                          badgeContent: Text(
                            "${_orderRepo.forConfirmationCount}",
                            style: const TextStyle(
                                fontSize: 11.0, color: Colors.white),
                          ),
                          child: Text(
                            'For Confirmation',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight:
                                  (currentIndex == 0) ? FontWeight.bold : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Tab(
                  icon: const Icon(FluentIcons.delivery_truck),
                  text: Container(
                    color: (currentIndex == 1) ? const Color(0xFFC1F8CF) : null,
                    child: BlocBuilder<OrdersBloc, OrdersState>(
                      buildWhen: (previous, current) => current is OrdersLoaded,
                      builder: (context, state) {
                        return Badge(
                          badgeColor: Colors.teal.light,
                          position: BadgePosition.topStart(),
                          badgeContent: Text(
                            "${_orderRepo.forDispatchCount}",
                            style: const TextStyle(
                                fontSize: 11.0, color: Colors.white),
                          ),
                          child: Text(
                            'For Dispatch',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight:
                                  (currentIndex == 1) ? FontWeight.bold : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Tab(
                  icon: const Icon(FluentIcons.completed),
                  text: Container(
                    color: (currentIndex == 2) ? const Color(0xFFC1F8CF) : null,
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight:
                            (currentIndex == 2) ? FontWeight.bold : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  icon: const Icon(FluentIcons.warning),
                  text: Container(
                    color: (currentIndex == 3) ? const Color(0xFFC1F8CF) : null,
                    child: Text(
                      'Canceled',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight:
                            (currentIndex == 3) ? FontWeight.bold : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
      ),
    );
  }
}
