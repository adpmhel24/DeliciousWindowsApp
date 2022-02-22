import 'package:equatable/equatable.dart';

abstract class WarehouseEvent extends Equatable {
  const WarehouseEvent();

  @override
  List<Object?> get props => [];
}

class FetchWarehouseFromAPI extends WarehouseEvent {}

class FetchWarehouseFromLocal extends WarehouseEvent {}
