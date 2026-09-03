import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'widgets/add_branch_section_title.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';

class AddBranchPage extends StatefulWidget {
  final UserType userType;

  const AddBranchPage({super.key, required this.userType});

  @override
  State<AddBranchPage> createState() => _AddBranchPageState();
}

class _AddBranchPageState extends State<AddBranchPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedCity;
  String? _selectedWorkingHours;
  bool _isHomeCollectionAvailable = false;

  final List<String> _cities = ['Cairo', 'Alexandria', 'Giza', 'Mansoura'];
  final List<String> _workingHoursOptions = [
    '07:00 AM - 09:00 PM (Daily)',
    '24/7 Operations',
    '08:00 AM - 10:00 PM (Mon-Fri)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form validated, in a real scenario we'd dispatch AddBranchEvent via bloc here.
      // E.g.: context.read<ManageBranchBloc>().add(AddBranchEvent(branch: newBranch));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Branch added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Branch',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddBranchSectionTitle(title: 'Branch Name'),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Enter branch name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              AddBranchSectionTitle(title: 'City / Area'),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: _inputDecoration('Select city'),
                items: _cities
                    .map(
                      (city) =>
                          DropdownMenuItem(value: city, child: Text(city)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCity = val),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              AddBranchSectionTitle(title: 'Detailed Address'),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: _inputDecoration('Enter detailed address'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              AddBranchSectionTitle(title: 'Phone Number'),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Enter phone number'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map, color: Color(0xFF1877F2)),
                label: const Text(
                  'Location on Map',
                  style: TextStyle(color: Color(0xFF1877F2)),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  side: const BorderSide(color: Color(0xFF1877F2)),
                ),
              ),
              SizedBox(height: 24.h),
              AddBranchSectionTitle(title: 'Location Working Hours'),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: _selectedWorkingHours,
                decoration: _inputDecoration('Select working hours'),
                items: _workingHoursOptions
                    .map(
                      (hours) =>
                          DropdownMenuItem(value: hours, child: Text(hours)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedWorkingHours = val),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch(
                    value: _isHomeCollectionAvailable,
                    onChanged: (val) =>
                        setState(() => _isHomeCollectionAvailable = val),
                    activeColor: const Color(0xFF2CC069),
                  ),
                  Expanded(
                    child: Text(
                      'Home collection service is available at this location.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF0F2D52),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                  backgroundColor: const Color(0xFF2CC069),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Add Branch',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF7A8FA6)),
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF1877F2)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    );
  }
}
