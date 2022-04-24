import 'package:equatable/equatable.dart';
import '/data/models/models.dart';

abstract class WarehouseState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  WarehouseState();

  @override
  List<Object?> get props => [];
}

class WhseInitState extends WarehouseState {}

class WhseLoadingState extends WarehouseState {}

class WarehouseLoadedState extends WarehouseState {
  final List<WarehouseModel> warehouses;

  WarehouseLoadedState(this.warehouses);

  @override
  List<Object?> get props => [warehouses];
}

class WhseErrorState extends WarehouseState {
  final String message;

  WhseErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
