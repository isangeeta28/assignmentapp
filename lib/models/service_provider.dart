import 'package:equatable/equatable.dart';

class ServiceProvider extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final String imageUrl;
  final String location;
  final double price;
  final List<String> services;

  const ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.services,
  });

  @override
  List<Object> get props => [id, name, category, description, rating, imageUrl, location, price, services];
}