import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order.dart';
import '../../utils/static_data.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
    on<CreateOrder>(_onCreateOrder);
  }

  void _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    await Future.delayed(Duration(milliseconds: 500));

    emit(OrderLoaded(orders: StaticData.orders));
  }

  void _onUpdateOrderStatus(UpdateOrderStatus event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    await Future.delayed(Duration(milliseconds: 300));

    final updatedOrders = StaticData.orders.map((order) {
      if (order.id == event.orderId) {
        return Order(
          id: order.id,
          customerId: order.customerId,
          serviceProviderId: order.serviceProviderId,
          serviceName: order.serviceName,
          status: event.status,
          createdAt: order.createdAt,
          amount: order.amount,
        );
      }
      return order;
    }).toList();

    StaticData.orders = updatedOrders;

    emit(OrderLoaded(orders: updatedOrders));
  }

  void _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    await Future.delayed(Duration(milliseconds: 300));

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerId: '1',
      serviceProviderId: event.serviceProviderId,
      serviceName: event.serviceName,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
      amount: event.amount,
    );

    StaticData.orders.add(newOrder);

    emit(OrderLoaded(orders: StaticData.orders));
  }
}