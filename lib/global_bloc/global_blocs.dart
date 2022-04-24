import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class GlobalBloc {
  static final authBloc = AuthBloc();

  static final salesTypeBloc = SalesTypeBloc();
  static final discTypeBloc = DiscTypeBloc();
  static final whseBloc = WarehouseBloc();
  static final customersBloc = CustomersBloc();
  static final cityMunicipalityBloc = CityMunicipalityBloc();
  static final brgyBloc = BrgyBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<SalesTypeBloc>(create: (context) => salesTypeBloc),
    BlocProvider<DiscTypeBloc>(create: (context) => discTypeBloc),
    BlocProvider<WarehouseBloc>(create: (context) => whseBloc),
    BlocProvider<CustomersBloc>(create: (context) => customersBloc),
    BlocProvider<CityMunicipalityBloc>(
        create: (context) => cityMunicipalityBloc),
    BlocProvider<BrgyBloc>(create: (context) => brgyBloc),
  ];

  static void dispose() {
    authBloc.close();
    salesTypeBloc.close();
    discTypeBloc.close();
    whseBloc.close();
    customersBloc.close();
    cityMunicipalityBloc.close();
    brgyBloc.close();
  }

  /// Singleton factory
  static final GlobalBloc _instance = GlobalBloc._internal();

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal();
}
