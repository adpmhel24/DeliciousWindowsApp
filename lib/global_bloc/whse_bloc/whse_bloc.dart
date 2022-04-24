import 'dart:io';

import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class WarehouseBloc extends Bloc<WarehouseEvent, WarehouseState> {
  final WarehouseRepo _warehouseRepository = AppRepo.whseRepository;
  WarehouseBloc() : super(WhseInitState()) {
    on<FetchWarehouseFromLocal>(_onFetchFromLocal);
    on<FetchWarehouseFromAPI>(_onFetchFromAPI);
  }

  Future<void> _onFetchFromLocal(
      FetchWarehouseFromLocal event, Emitter<WarehouseState> emit) async {
    emit(WhseLoadingState());
    try {
      if (_warehouseRepository.whses.isEmpty) {
        await _warehouseRepository.fetchWarehouses({"is_active": 1});
      }
      emit(WarehouseLoadedState(_warehouseRepository.whses));
    } on HttpException catch (e) {
      emit(WhseErrorState(e.message));
    }
  }

  Future<void> _onFetchFromAPI(
      FetchWarehouseFromAPI event, Emitter<WarehouseState> emit) async {
    emit(WhseLoadingState());
    try {
      await _warehouseRepository.fetchWarehouses({"is_active": 1});
      emit(WarehouseLoadedState(_warehouseRepository.whses));
    } on HttpException catch (e) {
      emit(WhseErrorState(e.message));
    }
  }
}
