import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class LoadServices extends ServiceEvent {}

class SearchServices extends ServiceEvent {
  final String query;

  const SearchServices({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends ServiceEvent {
  final String category;

  const FilterByCategory({required this.category});

  @override
  List<Object> get props => [category];
}