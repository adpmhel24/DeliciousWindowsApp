import '/global_bloc/whse_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './disc_type_bloc/bloc.dart';

import './sales_type_bloc/bloc.dart';
import 'auth_bloc/bloc.dart';

class GlobalBloc {
  static final authBloc = AuthBloc();

  static final salesTypeBloc = SalesTypeBloc();
  static final discTypeBloc = DiscTypeBloc();
  static final whseBloc = WarehouseBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<SalesTypeBloc>(create: (context) => salesTypeBloc),
    BlocProvider<DiscTypeBloc>(create: (context) => discTypeBloc),
    BlocProvider<WarehouseBloc>(create: (context) => whseBloc),
  ];

  static void dispose() {
    authBloc.close();
    salesTypeBloc.close();
    discTypeBloc.close();
    whseBloc.close();
  }

  /// Singleton factory
  static final GlobalBloc _instance = GlobalBloc._internal();

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal();
}
