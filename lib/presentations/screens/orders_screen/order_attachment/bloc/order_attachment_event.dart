part of 'order_attachment_bloc.dart';

abstract class OrderAttachmentEvent extends Equatable {
  const OrderAttachmentEvent();

  @override
  List<Object> get props => [];
}

class GetOrderAttachment extends OrderAttachmentEvent {
  final int orderId;
  const GetOrderAttachment(this.orderId);
  @override
  List<Object> get props => [orderId];
}
