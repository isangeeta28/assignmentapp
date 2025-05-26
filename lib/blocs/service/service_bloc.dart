import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/static_data.dart';
import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<LoadServices>(_onLoadServices);
    on<SearchServices>(_onSearchServices);
    on<FilterByCategory>(_onFilterByCategory);
  }

  void _onLoadServices(LoadServices event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());

    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));

    emit(ServiceLoaded(
      services: StaticData.serviceProviders,
      categories: StaticData.categories,
    ));
  }

  void _onSearchServices(SearchServices event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());

    await Future.delayed(Duration(milliseconds: 300));

    final filteredServices = StaticData.serviceProviders
        .where((service) =>
    service.name.toLowerCase().contains(event.query.toLowerCase()) ||
        service.category.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(ServiceLoaded(
      services: filteredServices,
      categories: StaticData.categories,
    ));
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());

    await Future.delayed(Duration(milliseconds: 300));

    final filteredServices = StaticData.serviceProviders
        .where((service) => service.category == event.category)
        .toList();

    emit(ServiceLoaded(
      services: filteredServices,
      categories: StaticData.categories,
    ));
  }
}