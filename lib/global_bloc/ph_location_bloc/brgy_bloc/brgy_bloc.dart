import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/repositories.dart';
import './bloc.dart';

class BrgyBloc extends Bloc<BrgyEvent, BrgyState> {
  BrgyBloc() : super(const BrgyState()) {
    on<FetchBrgyFromAPI>(_onFetchBrgyFromAPI);
    on<SearchBrgyByKeyword>(_onSearchBrgyByKeyword);
  }
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  void _onFetchBrgyFromAPI(
      FetchBrgyFromAPI event, Emitter<BrgyState> emit) async {
    emit(state.copyWith(status: BrgyStateStatus.loading));
    try {
      await _phLocationRepo.fetchBrgys(event.cityMunicipalityCode);
      emit(
        state.copyWith(
          status: BrgyStateStatus.success,
          brgys: _phLocationRepo.brgys,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(message: e.message, status: BrgyStateStatus.error));
    }
  }

  void _onSearchBrgyByKeyword(
      SearchBrgyByKeyword event, Emitter<BrgyState> emit) {
    emit(state.copyWith(status: BrgyStateStatus.loading));
    emit(
      state.copyWith(
        brgys: _phLocationRepo.searchBarangaysByKeyword(event.keyword),
        status: BrgyStateStatus.success,
      ),
    );
  }
}
