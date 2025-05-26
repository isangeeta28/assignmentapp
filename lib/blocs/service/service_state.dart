import 'package:equatable/equatable.dart';
import '../../models/service_provider.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceProvider> services;
  final List<String> categories;

  const ServiceLoaded({required this.services, required this.categories});

  @override
  List<Object> get props => [services, categories];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError({required this.message});

  @override
  List<Object> get props => [message];
}