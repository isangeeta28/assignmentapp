import 'package:equatable/equatable.dart';

enum OrderStatus { pending, confirmed, inProgress, completed, cancelled }

class Order extends Equatable {
  final String id;
  final String customerId;
  final String serviceProviderId;
  final String serviceName;
  final OrderStatus status;
  final DateTime createdAt;
  final double amount;

  const Order({
    required this.id,
    required this.customerId,
    required this.serviceProviderId,
    required this.serviceName,
    required this.status,
    required this.createdAt,
    required this.amount,
  });

  @override
  List<Object> get props => [id, customerId, serviceProviderId, serviceName, status, createdAt, amount];
}