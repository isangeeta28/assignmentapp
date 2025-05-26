import '../models/service_provider.dart';
import '../models/order.dart';

class StaticData {
  static List<String> categories = [
    'Cleaning',
    'Plumbing',
    'Electrical',
    'Painting',
    'Gardening',
    'Carpentry',
    'Beauty',
    'Tutoring',
  ];

  static List<ServiceProvider> serviceProviders = [
    ServiceProvider(
      id: '1',
      name: 'Clean Pro Services',
      category: 'Cleaning',
      description: 'Professional home and office cleaning services with eco-friendly products.',
      rating: 4.8,
      imageUrl: 'https://via.placeholder.com/150',
      location: 'Downtown Area',
      price: 50.0,
      services: ['House Cleaning', 'Office Cleaning', 'Deep Cleaning'],
    ),
    ServiceProvider(
      id: '2',
      name: 'Fix It Fast Plumbing',
      category: 'Plumbing',
      description: 'Quick and reliable plumbing solutions for all your needs.',
      rating: 4.6,
      imageUrl: 'https://via.placeholder.com/150',
      location: 'North Side',
      price: 75.0,
      services: ['Pipe Repair', 'Drain Cleaning', 'Installation'],
    ),
    ServiceProvider(
      id: '3',
      name: 'Spark Electric',
      category: 'Electrical',
      description: 'Licensed electricians for safe and efficient electrical work.',
      rating: 4.9,
      imageUrl: 'https://via.placeholder.com/150',
      location: 'City Center',
      price: 80.0,
      services: ['Wiring', 'Lighting', 'Panel Upgrade'],
    ),
    ServiceProvider(
      id: '4',
      name: 'Color Masters',
      category: 'Painting',
      description: 'Transform your space with our professional painting services.',
      rating: 4.7,
      imageUrl: 'https://via.placeholder.com/150',
      location: 'South Area',
      price: 60.0,
      services: ['Interior Painting', 'Exterior Painting', 'Wall Design'],
    ),
  ];

  static List<Order> orders = [
    Order(
      id: '1',
      customerId: '1',
      serviceProviderId: '1',
      serviceName: 'House Cleaning',
      status: OrderStatus.pending,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      amount: 50.0,
    ),
    Order(
      id: '2',
      customerId: '2',
      serviceProviderId: '2',
      serviceName: 'Pipe Repair',
      status: OrderStatus.confirmed,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      amount: 75.0,
    ),
    Order(
      id: '3',
      customerId: '3',
      serviceProviderId: '3',
      serviceName: 'Wiring Installation',
      status: OrderStatus.inProgress,
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      amount: 120.0,
    ),
  ];
}