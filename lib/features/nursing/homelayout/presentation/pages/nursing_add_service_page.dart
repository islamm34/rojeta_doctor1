import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_service_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_dropdown_field.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_gender_radio.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/pages/widgets/nursing_labeled_text_field.dart';

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
  String? _selectedService;
  String? _pricingType;
  String _selectedGender = 'Both';
  bool _isActive = true;

  @override
  void dispose() {
    _descriptionController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState?.validate() ?? false) {
      final s = context.strings;
      final newService = NursingServiceModel(
        title: _selectedService ?? s.service12Hour,
        subtitle: _descriptionController.text.trim(),
        durationTag: _durationController.text.trim(),
        bulletPoints: [s.customServiceTerms, s.standardTermsApply],
        price: double.tryParse(_priceController.text.trim()),
        pricingType: _pricingType,
        availableGender: _selectedGender,
        isActive: _isActive,
      );

      context.read<NursingBloc>().add(AddNursingServiceEvent(newService));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;

    final services = [
      s.service12Hour,
      s.service24Hour,
      s.serviceHomeVisit,
      s.serviceElderlyCare,
      s.serviceBabyCare,
    ];

    final pricingTypes = [s.perVisit, s.perHour, s.perDay, s.perMonth];

    _selectedService ??= services.first;
    _pricingType ??= pricingTypes.first;

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
          s.addNewService,
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
                  s.serviceDetails,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  s.serviceDetailsSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 24.h),
                NursingDropdownField(
                  label: s.service,
                  value: _selectedService!,
                  items: services,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedService = val);
                  },
                ),
                SizedBox(height: 16.h),
                NursingLabeledTextField(
                  controller: _descriptionController,
                  label: s.serviceDescription,
                  hint: s.serviceDescriptionHint,
                  maxLines: 4,
                  validator: (val) =>
                      val == null || val.isEmpty ? s.requiredField : null,
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NursingDropdownField(
                        label: s.pricingType,
                        value: _pricingType!,
                        items: pricingTypes,
                        onChanged: (val) {
                          if (val != null) setState(() => _pricingType = val);
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: NursingLabeledTextField(
                        controller: _priceController,
                        label: s.price,
                        hint: '0.00',
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: Text(
                            s.egp,
                            style: const TextStyle(
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
                            val == null || val.isEmpty ? s.requiredField : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  s.availableGender,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    NursingGenderRadio(
                      title: s.male,
                      selectedValue: _selectedGender == 'Male'
                          ? s.male
                          : (_selectedGender == 'Female' ? s.female : s.both),
                      onChanged: (_) =>
                          setState(() => _selectedGender = 'Male'),
                    ),
                    SizedBox(width: 16.w),
                    NursingGenderRadio(
                      title: s.female,
                      selectedValue: _selectedGender == 'Male'
                          ? s.male
                          : (_selectedGender == 'Female' ? s.female : s.both),
                      onChanged: (_) =>
                          setState(() => _selectedGender = 'Female'),
                    ),
                    SizedBox(width: 16.w),
                    NursingGenderRadio(
                      title: s.both,
                      selectedValue: _selectedGender == 'Male'
                          ? s.male
                          : (_selectedGender == 'Female' ? s.female : s.both),
                      onChanged: (_) =>
                          setState(() => _selectedGender = 'Both'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                NursingLabeledTextField(
                  controller: _durationController,
                  label: s.duration,
                  hint: s.durationHint,
                  validator: (val) =>
                      val == null || val.isEmpty ? s.requiredField : null,
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
                            s.activeStatus,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0284C7),
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            s.toggleVisibilityProviderList,
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
              Text(
                s.addNewService,
                style: const TextStyle(
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
}
