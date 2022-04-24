part of 'order_attachment_bloc.dart';

enum OrderAttachmentStateStatus { init, loading, success, error }

class OrderAttachmentState extends Equatable {
  final OrderAttachmentStateStatus status;
  final List<OrderAttachmentModel> attachments;
  final String message;

  const OrderAttachmentState(
      {this.status = OrderAttachmentStateStatus.init,
      this.attachments = const [],
      this.message = ''});

  OrderAttachmentState copyWith({
    OrderAttachmentStateStatus? status,
    List<OrderAttachmentModel>? attachments,
    String? message,
  }) {
    return OrderAttachmentState(
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        attachments,
        message,
      ];
}
