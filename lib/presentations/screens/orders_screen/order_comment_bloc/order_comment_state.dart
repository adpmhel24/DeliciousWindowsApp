import 'package:delicious_windows_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

enum OrderCommentStatus { init, loading, success, failed }

class OrderCommentState extends Equatable {
  final OrderCommentStatus status;
  final List<CommentModel> orderComments;
  final String? message;

  const OrderCommentState({
    this.status = OrderCommentStatus.init,
    this.orderComments = const [],
    this.message,
  });

  OrderCommentState copyWith({
    OrderCommentStatus? status,
    List<CommentModel>? orderComments,
    String? message,
  }) {
    return OrderCommentState(
      status: status ?? this.status,
      orderComments: orderComments ?? this.orderComments,
      message: this.message,
    );
  }

  @override
  List<Object?> get props => [status, orderComments];
}
