import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../data/models/clinic_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../widgets/add_clinic/additional_services_pricing_section.dart';
import '../widgets/add_clinic/clinic_basic_info_section.dart';
import '../widgets/add_clinic/clinic_photos_section.dart';
import '../widgets/add_clinic/clinic_services_pricing_section.dart';
import '../widgets/add_clinic/consultation_time_section.dart';
import '../widgets/add_clinic/working_hours_section.dart';

class AddClinicPage extends StatefulWidget {
  final ClinicModel? clinic;

  const AddClinicPage({super.key, this.clinic});

  @override
  State<AddClinicPage> createState() => _AddClinicPageState();
}

class _AddClinicPageState extends State<AddClinicPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _governorateController;
  late final TextEditingController _cityController;
  late final TextEditingController _addressController;
  late final TextEditingController _consultationTimeController;
  late final TextEditingController _visitPriceController;
  late final TextEditingController _followUpPriceController;
  late final TextEditingController _homeVisitPriceController;
  late final TextEditingController _videoCallPriceController;

  Map<String, dynamic> _workingHours = {};
  List<String> _photos = [];
  bool _clinicVisitEnabled = true;
  bool _followUpEnabled = true;
  bool _homeVisitEnabled = false;
  bool _videoCallEnabled = false;

  @override
  void initState() {
    super.initState();
    final clinic = widget.clinic;

    _nameController = TextEditingController(text: clinic?.name ?? '');
    _phoneController = TextEditingController(text: clinic?.phone ?? '');
    _governorateController =
        TextEditingController(text: clinic?.governorate ?? '');
    _cityController = TextEditingController(text: clinic?.city ?? '');
    _addressController = TextEditingController(text: clinic?.fullAddress ?? '');
    _consultationTimeController = TextEditingController(
      text: clinic?.consultationTime != null
          ? clinic!.consultationTime.toString()
          : '30',
    );
    _visitPriceController = TextEditingController(
      text: clinic?.clinicVisitPrice != null
          ? clinic!.clinicVisitPrice!.toStringAsFixed(0)
          : '300',
    );
    _followUpPriceController = TextEditingController(
      text: clinic?.followUpPrice != null
          ? clinic!.followUpPrice!.toStringAsFixed(0)
          : '150',
    );
    _homeVisitPriceController = TextEditingController(
      text: clinic?.homeVisitPrice != null
          ? clinic!.homeVisitPrice!.toStringAsFixed(0)
          : '600',
    );
    _videoCallPriceController = TextEditingController(
      text: clinic?.videoCallPrice != null
          ? clinic!.videoCallPrice!.toStringAsFixed(0)
          : '300',
    );

    if (clinic != null) {
      _workingHours = Map<String, dynamic>.from(clinic.workingHours);
      _photos = List<String>.from(clinic.photos);
      _clinicVisitEnabled = clinic.clinicVisitPrice != null;
      _followUpEnabled = clinic.followUpPrice != null;
      _homeVisitEnabled = clinic.homeVisitPrice != null;
      _videoCallEnabled = clinic.videoCallPrice != null;
    } else {
      _workingHours = {
        'sat': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'sun': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'mon': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'tue': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'wed': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'thu': {'is_open': true, 'start': '09:00 AM', 'end': '10:00 PM'},
        'fri': {'is_open': false, 'start': '09:00 AM', 'end': '05:00 PM'},
      };
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _consultationTimeController.dispose();
    _visitPriceController.dispose();
    _followUpPriceController.dispose();
    _homeVisitPriceController.dispose();
    _videoCallPriceController.dispose();
    super.dispose();
  }

  void _submitClinic(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final governorate = _governorateController.text.trim();
    final city = _cityController.text.trim();
    final address = _addressController.text.trim();
    final consultationTime =
        int.tryParse(_consultationTimeController.text.trim());
    final visitPrice = _clinicVisitEnabled
        ? double.tryParse(_visitPriceController.text.trim())
        : null;
    final followUpPrice = _followUpEnabled
        ? double.tryParse(_followUpPriceController.text.trim())
        : null;
    final homeVisitPrice = _homeVisitEnabled
        ? double.tryParse(_homeVisitPriceController.text.trim())
        : null;
    final videoCallPrice = _videoCallEnabled
        ? double.tryParse(_videoCallPriceController.text.trim())
        : null;

    if (widget.clinic != null) {
      final updatedClinic = widget.clinic!.copyWith(
        name: name,
        phone: phone.isNotEmpty ? phone : null,
        governorate: governorate.isNotEmpty ? governorate : null,
        city: city.isNotEmpty ? city : null,
        fullAddress: address.isNotEmpty ? address : null,
        consultationTime: consultationTime,
        workingHours: _workingHours,
        clinicVisitPrice: visitPrice,
        followUpPrice: followUpPrice,
        homeVisitPrice: homeVisitPrice,
        videoCallPrice: videoCallPrice,
        photos: _photos,
      );
      context.read<ProfileBloc>().add(
            UpdateClinicSubmittedEvent(updatedClinic),
          );
    } else {
      final newClinic = ClinicModel(
        id: '',
        name: name,
        phone: phone.isNotEmpty ? phone : null,
        governorate: governorate.isNotEmpty ? governorate : null,
        city: city.isNotEmpty ? city : null,
        fullAddress: address.isNotEmpty ? address : null,
        consultationTime: consultationTime,
        workingHours: _workingHours,
        clinicVisitPrice: visitPrice,
        followUpPrice: followUpPrice,
        homeVisitPrice: homeVisitPrice,
        videoCallPrice: videoCallPrice,
        photos: _photos,
      );
      context.read<ProfileBloc>().add(
            AddClinicSubmittedEvent(newClinic),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;
    final isEditing = widget.clinic != null;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? strings.clinicUpdatedSuccessfully
                    : strings.clinicAddedSuccessfully,
              ),
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state.status == ProfileStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == ProfileStatus.loading;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(isEditing ? strings.edit : strings.addClinicTitle),
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: false,
            iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
            titleTextStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(color: theme.colorScheme.primary),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: theme.colorScheme.outlineVariant
                              .withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClinicBasicInfoSection(
                              nameController: _nameController,
                              phoneController: _phoneController,
                              governorateController: _governorateController,
                              cityController: _cityController,
                              addressController: _addressController,
                            ),
                            const SizedBox(height: 24),
                            ClinicPhotosSection(
                              photos: _photos,
                              onPhotosChanged: (photos) {
                                setState(() => _photos = photos);
                              },
                            ),
                            const SizedBox(height: 24),
                            ConsultationTimeSection(
                              controller: _consultationTimeController,
                            ),
                            const SizedBox(height: 24),
                            WorkingHoursSection(
                              initialWorkingHours: widget.clinic?.workingHours,
                              onWorkingHoursChanged: (hours) {
                                _workingHours = hours;
                              },
                            ),
                            const SizedBox(height: 24),
                            ClinicServicesPricingSection(
                              visitPriceController: _visitPriceController,
                              followUpPriceController: _followUpPriceController,
                              initialVisitEnabled: _clinicVisitEnabled,
                              initialFollowUpEnabled: _followUpEnabled,
                              onVisitEnabledChanged: (val) {
                                _clinicVisitEnabled = val;
                              },
                              onFollowUpEnabledChanged: (val) {
                                _followUpEnabled = val;
                              },
                            ),
                            const SizedBox(height: 24),
                            AdditionalServicesPricingSection(
                              homeVisitPriceController:
                                  _homeVisitPriceController,
                              videoCallPriceController:
                                  _videoCallPriceController,
                              initialHomeVisitEnabled: _homeVisitEnabled,
                              initialVideoCallEnabled: _videoCallEnabled,
                              onHomeVisitEnabledChanged: (val) {
                                _homeVisitEnabled = val;
                              },
                              onVideoCallEnabledChanged: (val) {
                                _videoCallEnabled = val;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color:
                            theme.colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isLoading ? null : () => _submitClinic(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : Text(isEditing ? strings.saveBtn : strings.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
