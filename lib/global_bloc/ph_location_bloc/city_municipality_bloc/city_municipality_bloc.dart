import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/repositories.dart';
import './bloc.dart';

class CityMunicipalityBloc
    extends Bloc<CityMunicipalityEvent, CityMunicipalityState> {
  CityMunicipalityBloc() : super(const CityMunicipalityState()) {
    on<FetchCityMunicipalityFromApi>(onFetchCityMunicipalityFromApi);
    on<FetchCityMunicipalityFromLocal>(onFetchCityMunicipalityFromLocal);
    on<SearchCityMunicipalityByKeyword>(onsearchCityMunicipalityByKeyword);
  }
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  void onFetchCityMunicipalityFromApi(FetchCityMunicipalityFromApi event,
      Emitter<CityMunicipalityState> emit) async {
    emit(state.copyWith(status: CityMunicipalityStateStatus.loading));
    try {
      await _phLocationRepo.fetchCitiesMunicipalities();
      emit(
        state.copyWith(
          cityMunicipality: _phLocationRepo.cities,
          status: CityMunicipalityStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: CityMunicipalityStateStatus.error,
        ),
      );
    }
  }

  void onFetchCityMunicipalityFromLocal(FetchCityMunicipalityFromLocal event,
      Emitter<CityMunicipalityState> emit) async {
    emit(state.copyWith(status: CityMunicipalityStateStatus.loading));
    try {
      if (_phLocationRepo.cities.isEmpty) {
        await _phLocationRepo.fetchCitiesMunicipalities();
      }
      emit(
        state.copyWith(
          cityMunicipality: _phLocationRepo.cities,
          status: CityMunicipalityStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: CityMunicipalityStateStatus.error,
        ),
      );
    }
  }

  void onsearchCityMunicipalityByKeyword(SearchCityMunicipalityByKeyword event,
      Emitter<CityMunicipalityState> emit) {
    emit(state.copyWith(status: CityMunicipalityStateStatus.loading));
    emit(
      state.copyWith(
        cityMunicipality:
            _phLocationRepo.searchCityMunicipalityByKeyword(event.keyword),
        status: CityMunicipalityStateStatus.success,
      ),
    );
  }
}
