import 'package:flutter_bloc/flutter_bloc.dart';

import './disc_type_bloc/bloc.dart';

import './sales_type_bloc/bloc.dart';

class GlobalBloc {
  static final salesTypeBloc = SalesTypeBloc();
  static final discTypeBloc = DiscTypeBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<SalesTypeBloc>(create: (context) => salesTypeBloc),
    BlocProvider<DiscTypeBloc>(create: (context) => discTypeBloc),
  ];

  static void dispose() {
    salesTypeBloc.close();
    discTypeBloc.close();
  }

  /// Singleton factory
  static final GlobalBloc _instance = GlobalBloc._internal();

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal();
}
