import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_service_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';

class NursingAddServicePage extends StatefulWidget {
  const NursingAddServicePage({super.key});

  @override
  State<NursingAddServicePage> createState() => _NursingAddServicePageState();
}

class _NursingAddServicePageState extends State<NursingAddServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedService = '12-Hour Nursing';
  String _pricingType = 'Per Visit';
  String _selectedGender = 'Both';
  bool _isActive = true;

  final List<String> _services = [
    '12-Hour Nursing',
    '24-Hour Nursing',
    'Home Visit',
    'Elderly Care',
    'Baby Care',
  ];

  final List<String> _pricingTypes = [
    'Per Visit',
    'Per Hour',
    'Per Day',
    'Per Month',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState?.validate() ?? false) {
      final newService = NursingServiceModel(
        title: _selectedService,
        subtitle: _descriptionController.text.trim(),
        durationTag: _durationController.text.trim(),
        bulletPoints: const ['Custom service', 'Standard terms apply'],
        // iconColorCode: 0xFF3B82F6, // Default Blue
        // iconCodePoint: 0xe03a, // Default Time icon
      );

      context.read<NursingBloc>().add(AddNursingServiceEvent(newService));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add New Service',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Details',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Provide the specifics of the nursing service\nyou want to offer.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 24.h),
                _buildDropdownField(
                  label: 'Service',
                  value: _selectedService,
                  items: _services,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedService = val);
                  },
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Service Description',
                  hint:
                      'Describe the care provided, responsibilities,\nand specific clinical tasks...',
                  maxLines: 4,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        label: 'Pricing Type',
                        value: _pricingType,
                        items: _pricingTypes,
                        onChanged: (val) {
                          if (val != null) setState(() => _pricingType = val);
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _priceController,
                        label: 'Price',
                        hint: '0.00',
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 16, right: 8),
                          child: Text(
                            'EGP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Available Gender',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildGenderRadio('Male'),
                    SizedBox(width: 16.w),
                    _buildGenderRadio('Female'),
                    SizedBox(width: 16.w),
                    _buildGenderRadio('Both'),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _durationController,
                  label: 'Duration',
                  hint: 'e.g., 12 Hours, Daily',
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                  maxLines: 2,
                ),
                SizedBox(height: 24.h),
                const Divider(color: Color(0xFFE2E8F0)),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Status',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0284C7),
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Toggle visibility on the provider list',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isActive,
                      onChanged: (val) => setState(() => _isActive = val),
                      activeThumbColor: const Color(0xFF0D9488),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
        child: ElevatedButton(
          onPressed: _saveService,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: Colors.white, size: 20),
              SizedBox(width: 8.w),
              const Text(
                'Add Service',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderRadio(String title) {
    return InkWell(
      onTap: () => setState(() => _selectedGender = title),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedGender == title
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(3.w),
            child: _selectedGender == title
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF3B82F6),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    Widget? prefix,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            prefixIcon: prefix != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [prefix],
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
            fontSize: 12,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
          style: const TextStyle(color: Color(0xFF334155), fontSize: 14),
          items: items.map((cat) {
            return DropdownMenuItem(value: cat, child: Text(cat));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
      ],
    );
  }
}
