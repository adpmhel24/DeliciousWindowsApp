import 'package:equatable/equatable.dart';

abstract class BrgyEvent extends Equatable {
  const BrgyEvent();
  @override
  List<Object?> get props => [];
}

class FetchBrgyFromAPI extends BrgyEvent {
  final String cityMunicipalityCode;
  const FetchBrgyFromAPI(this.cityMunicipalityCode);
  @override
  List<Object?> get props => [cityMunicipalityCode];
}

class SearchBrgyByKeyword extends BrgyEvent {
  final String keyword;

  const SearchBrgyByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
