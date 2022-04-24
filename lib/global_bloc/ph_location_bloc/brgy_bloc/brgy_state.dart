import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

enum BrgyStateStatus { init, loading, success, error }

class BrgyState extends Equatable {
  final BrgyStateStatus status;
  final List<BrgyModel> brgys;
  final String message;

  const BrgyState({
    this.status = BrgyStateStatus.init,
    this.brgys = const [],
    this.message = "",
  });

  BrgyState copyWith({
    BrgyStateStatus? status,
    List<BrgyModel>? brgys,
    String? message,
  }) {
    return BrgyState(
      status: status ?? this.status,
      brgys: brgys ?? this.brgys,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, brgys, message];
}
