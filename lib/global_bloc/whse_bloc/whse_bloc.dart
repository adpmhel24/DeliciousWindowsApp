import 'dart:io';

import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class WarehouseBloc extends Bloc<WarehouseEvent, WarehouseState> {
  final WarehouseRepo _warehouseRepository = AppRepo.whseRepository;
  WarehouseBloc() : super(InitState()) {
    on<FetchWarehouseFromLocal>(_onFetchFromLocal);
    on<FetchWarehouseFromAPI>(_onFetchFromAPI);
  }

  Future<void> _onFetchFromLocal(
      FetchWarehouseFromLocal event, Emitter<WarehouseState> emit) async {
    emit(LoadingState());
    try {
      if (_warehouseRepository.whses.isEmpty) {
        await _warehouseRepository.fetchWarehouses();
      }
      emit(WarehouseLoadedState(_warehouseRepository.whses));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  Future<void> _onFetchFromAPI(
      FetchWarehouseFromAPI event, Emitter<WarehouseState> emit) async {
    emit(LoadingState());
    try {
      await _warehouseRepository.fetchWarehouses();
      emit(WarehouseLoadedState(_warehouseRepository.whses));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }
}
