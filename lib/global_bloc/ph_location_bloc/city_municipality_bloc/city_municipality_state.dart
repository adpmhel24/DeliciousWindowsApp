import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

enum CityMunicipalityStateStatus { init, loading, success, error }

class CityMunicipalityState extends Equatable {
  final CityMunicipalityStateStatus status;
  final List<CityMunicipalityModel> cityMunicipality;
  final String message;

  const CityMunicipalityState({
    this.status = CityMunicipalityStateStatus.init,
    this.cityMunicipality = const [],
    this.message = "",
  });

  CityMunicipalityState copyWith({
    CityMunicipalityStateStatus? status,
    List<CityMunicipalityModel>? cityMunicipality,
    String? message,
  }) {
    return CityMunicipalityState(
      status: status ?? this.status,
      cityMunicipality: cityMunicipality ?? this.cityMunicipality,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cityMunicipality,
        message,
      ];
}

// class CityMunicipalityState extends Equatable {
//   const CityMunicipalityState();
//   @override
//   List<Object?> get props => [];
// }

// class CityMunicipalityInitState extends CityMunicipalityState {}

// class CityMunicipalityLoadingState extends CityMunicipalityState {}

// class CityMunicipalityLoadedState extends CityMunicipalityState {
//   final List<CityMunicipalityModel> citiesMunicipalities;
//   const CityMunicipalityLoadedState(this.citiesMunicipalities);
//   @override
//   List<Object?> get props => [citiesMunicipalities];
// }

// class CityMunicipalityEmptyState extends CityMunicipalityState {}

// class CityMunicipalityErrorState extends CityMunicipalityState {
//   final String message;
//   const CityMunicipalityErrorState(this.message);

//   @override
//   List<Object?> get props => [message];
// }
