import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_label_info.dart';
import '/presentations/screens/orders_screen/orders_bloc/blocs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data/repositories/repositories.dart';
import 'components/for_dispatch_orders.dart';
import './components/order_comment_bloc/bloc.dart';
import './components/order_details/order_bloc/bloc.dart';
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

  DateTime? startDate;
  DateTime? endDate;

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              CustomDatePicker.singleDatePicker(
                                context,
                                initialSelectedDate: startDate,
                                onSubmit: (value) {
                                  setState(() {
                                    startDate = value != null
                                        ? DateTime.parse(value.toString())
                                        : null;
                                  });

                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: LabelInfo(
                              label: "Start Delivery Date",
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(startDate != null
                                      ? DateFormat("MM/dd/yyyy")
                                          .format(startDate!)
                                      : ""),
                                  const Icon(FluentIcons.calendar),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      SizedBox(
                        width: 200,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              CustomDatePicker.singleDatePicker(
                                context,
                                initialSelectedDate: endDate,
                                onSubmit: (value) {
                                  setState(() {
                                    endDate = value != null
                                        ? DateTime.parse(value.toString())
                                        : null;
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: LabelInfo(
                              label: "End Delivery Date",
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(endDate != null
                                      ? DateFormat("MM/dd/yyyy")
                                          .format(endDate!)
                                      : ""),
                                  const Icon(FluentIcons.calendar),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      IconButton(
                          icon: const Icon(FluentIcons.search),
                          style: ButtonStyle(
                            iconSize: ButtonState.all(20),
                          ),
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
                      gridKey.currentState!.refresh(false);
                    },
                  ),
                ],
              ),
            ),
            content: TabView(
              currentIndex: currentIndex,
              closeButtonVisibility: CloseButtonVisibilityMode.never,
              onChanged: (index) {
                DateTime? sDate;
                DateTime? eDate;
                if (index == 0) {
                  sDate = null;
                  eDate = null;
                } else if (index == 1) {
                  sDate = null;
                  eDate = null;
                } else {
                  sDate = DateTime.now();
                  eDate = DateTime.now();
                }
                setState(() {
                  currentIndex = index;
                  startDate = sDate;
                  endDate = eDate;
                });
              },
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
