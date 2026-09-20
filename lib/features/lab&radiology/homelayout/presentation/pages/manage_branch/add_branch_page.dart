import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../../../data/models/branch_model.dart';
import '../../../presentation/bloc/manage_branch/manage_branch_bloc.dart';
import '../../../presentation/bloc/manage_branch/manage_branch_event.dart';
import '../../../presentation/bloc/manage_branch/manage_branch_state.dart';
import 'widgets/add_branch_section_title.dart';

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

  void _submitForm(BuildContext blocContext) {
    if (_formKey.currentState!.validate()) {
      final fullAddress = _selectedCity != null
          ? '${_addressController.text.trim()}, $_selectedCity'
          : _addressController.text.trim();
      final branch = BranchModel(
        name: _nameController.text.trim(),
        address: fullAddress,
        phone: _phoneController.text.trim(),
        workingHours: _selectedWorkingHours,
        isHomeCollectionAvailable: _isHomeCollectionAvailable,
      );

      blocContext.read<ManageBranchBloc>().add(AddBranchEvent(branch: branch));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ManageBranchBloc>(),
      child: BlocConsumer<ManageBranchBloc, ManageBranchState>(
        listener: (context, state) {
          if (state.status == ManageBranchStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.strings.branchAddedSuccessfully)),
            );
            Navigator.pop(context, true);
          } else if (state.status == ManageBranchStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final isLoading = state.status == ManageBranchStatus.loading;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                context.strings.addBranch,
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
                    AddBranchSectionTitle(title: context.strings.branchName),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration(context.strings.branchName),
                      validator: (value) => value == null || value.isEmpty
                          ? context.strings.required
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    AddBranchSectionTitle(title: context.strings.city),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCity,
                      decoration: _inputDecoration(context.strings.city),
                      items: _cities
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedCity = val),
                      validator: (value) =>
                          value == null ? context.strings.required : null,
                    ),
                    SizedBox(height: 16.h),
                    AddBranchSectionTitle(title: context.strings.branchAddress),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: _inputDecoration(
                        context.strings.branchAddress,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? context.strings.required
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    AddBranchSectionTitle(title: context.strings.phoneNumber),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration(context.strings.phoneNumber),
                      validator: (value) => value == null || value.isEmpty
                          ? context.strings.required
                          : null,
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
                    const AddBranchSectionTitle(
                      title: 'Location Working Hours',
                    ),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedWorkingHours,
                      decoration: _inputDecoration('Select working hours'),
                      items: _workingHoursOptions
                          .map(
                            (hours) => DropdownMenuItem(
                              value: hours,
                              child: Text(hours),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedWorkingHours = val),
                      validator: (value) =>
                          value == null ? context.strings.required : null,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Switch(
                          value: _isHomeCollectionAvailable,
                          onChanged: (val) =>
                              setState(() => _isHomeCollectionAvailable = val),
                          activeThumbColor: const Color(0xFF2CC069),
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
                      onPressed: isLoading ? null : () => _submitForm(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        backgroundColor: const Color(0xFF2CC069),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              context.strings.addBranch,
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
        },
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
