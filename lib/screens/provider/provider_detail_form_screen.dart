import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../widgets/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/static_data.dart';
import '../../widgets/custom_text_feild.dart';
import '../auth/login_screen.dart';

class ProviderDetailFormScreen extends StatefulWidget {
  @override
  _ProviderDetailFormScreenState createState() => _ProviderDetailFormScreenState();
}

class _ProviderDetailFormScreenState extends State<ProviderDetailFormScreen> {
  final _businessNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();

  String? selectedCategory;
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile Details'),
        backgroundColor: AppColors.primaryBlue,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete Your Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Provide details to help customers find and choose your services',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightGray,
                ),
              ),
              SizedBox(height: 30),
              CustomTextField(
                label: 'Business Name',
                hint: 'Enter your business name',
                controller: _businessNameController,
                prefixIcon: Icons.business,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightGray),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        hint: Text('Select a category'),
                        items: StaticData.categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Description',
                hint: 'Describe your services and experience',
                controller: _descriptionController,
                prefixIcon: Icons.description,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Location',
                hint: 'Enter your service area',
                controller: _locationController,
                prefixIcon: Icons.location_on,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Hourly Rate (\$)',
                hint: 'Enter your hourly rate',
                controller: _priceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.attach_money,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Years of Experience',
                hint: 'Enter years of experience',
                controller: _experienceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.work,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services Offered',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Select the services you provide',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.lightGray,
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _getServicesForCategory().map((service) {
                      final isSelected = selectedServices.contains(service);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedServices.remove(service);
                            } else {
                              selectedServices.add(service);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryBlue.withOpacity(0.2)
                                : AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.lightGray,
                            ),
                          ),
                          child: Text(
                            service,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.darkGray,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 30),
              CustomButton(
                text: 'Save Profile',
                onPressed: () {
                  if (_validateForm()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile saved successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: AppColors.primaryBlue, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Profile Tips',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• Complete all fields to increase your visibility\n'
                          '• Write a detailed description of your services\n'
                          '• Set competitive pricing to attract customers\n'
                          '• Select multiple services to reach more clients',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGray,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getServicesForCategory() {
    if (selectedCategory == null) {
      return ['General Service', 'Consultation', 'Basic Support'];
    }

    switch (selectedCategory!.toLowerCase()) {
      case 'cleaning':
        return ['House Cleaning', 'Office Cleaning', 'Deep Cleaning', 'Window Cleaning'];
      case 'plumbing':
        return ['Pipe Repair', 'Drain Cleaning', 'Installation', 'Emergency Repair'];
      case 'electrical':
        return ['Wiring', 'Lighting', 'Panel Upgrade', 'Appliance Installation'];
      case 'painting':
        return ['Interior Painting', 'Exterior Painting', 'Wall Design', 'Touch-ups'];
      case 'gardening':
        return ['Lawn Care', 'Plant Care', 'Garden Design', 'Tree Trimming'];
      case 'carpentry':
        return ['Furniture Repair', 'Custom Furniture', 'Installation', 'Renovation'];
      case 'beauty':
        return ['Hair Styling', 'Makeup', 'Nail Care', 'Skincare'];
      case 'tutoring':
        return ['Math Tutoring', 'English Tutoring', 'Science Tutoring', 'Test Prep'];
      default:
        return ['General Service', 'Consultation', 'Basic Support'];
    }
  }

  bool _validateForm() {
    if (_businessNameController.text.isEmpty) {
      _showErrorSnackBar('Please enter business name');
      return false;
    }
    if (selectedCategory == null) {
      _showErrorSnackBar('Please select a category');
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      _showErrorSnackBar('Please enter description');
      return false;
    }
    if (_locationController.text.isEmpty) {
      _showErrorSnackBar('Please enter location');
      return false;
    }
    if (_priceController.text.isEmpty) {
      _showErrorSnackBar('Please enter hourly rate');
      return false;
    }
    if (selectedServices.isEmpty) {
      _showErrorSnackBar('Please select at least one service');
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}