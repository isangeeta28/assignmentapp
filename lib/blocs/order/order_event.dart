import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final OrderStatus status;

  const UpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object> get props => [orderId, status];
}

class CreateOrder extends OrderEvent {
  final String serviceProviderId;
  final String serviceName;
  final double amount;

  const CreateOrder({
    required this.serviceProviderId,
    required this.serviceName,
    required this.amount,
  });

  @override
  List<Object> get props => [serviceProviderId, serviceName, amount];
}