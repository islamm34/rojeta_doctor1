import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_event.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_state.dart';

import 'widgets/lab_info_form.dart';
import 'widgets/unsaved_changes_bottom_card.dart';
import 'widgets/verification_status_card.dart';

class LabInfoPage extends StatefulWidget {
  final bool isRadiology;

  const LabInfoPage({super.key, required this.isRadiology});

  @override
  State<LabInfoPage> createState() => _LabInfoPageState();
}

class _LabInfoPageState extends State<LabInfoPage> {
  final _nameController = TextEditingController();
  final _licenseController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _hasUnsavedChanges = false;
  bool _isPopulating = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<SettingsBloc>();
    _populateData(bloc.state);
    bloc.add(LoadLabInfoEvent());

    _nameController.addListener(_onTextChanged);
    _licenseController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
    _phoneController.addListener(_onTextChanged);
    _descriptionController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_isPopulating && !_hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_onTextChanged);
    _licenseController.removeListener(_onTextChanged);
    _emailController.removeListener(_onTextChanged);
    _phoneController.removeListener(_onTextChanged);
    _descriptionController.removeListener(_onTextChanged);

    _nameController.dispose();
    _licenseController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _populateData(SettingsState state) {
    if (state.labInfo != null && !_hasUnsavedChanges) {
      _isPopulating = true;
      _nameController.text = state.labInfo!.labName ?? '';
      _licenseController.text = state.labInfo!.licenseNumber ?? '';
      _emailController.text = state.labInfo!.primaryContactEmail ?? '';
      _phoneController.text = state.labInfo!.phoneNumber ?? '';
      _descriptionController.text = state.labInfo!.laboratoryDescription ?? '';
      _isPopulating = false;
    }
  }

  void _onSave() {
    context.read<SettingsBloc>().add(
      UpdateLabInfoEvent(
        labName: _nameController.text,
        licenseNumber: _licenseController.text,
        primaryContactEmail: _emailController.text,
        phoneNumber: _phoneController.text,
        description: _descriptionController.text,
      ),
    );
    setState(() {
      _hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.strings.detailsSavedSuccessfully)),
    );
  }

  void _onCancel() {
    final state = context.read<SettingsBloc>().state;
    if (state.labInfo != null) {
      setState(() {
        _hasUnsavedChanges = false;
        _isPopulating = true;
        _nameController.text = state.labInfo!.labName ?? '';
        _licenseController.text = state.labInfo!.licenseNumber ?? '';
        _emailController.text = state.labInfo!.primaryContactEmail ?? '';
        _phoneController.text = state.labInfo!.phoneNumber ?? '';
        _descriptionController.text =
            state.labInfo!.laboratoryDescription ?? '';
        _isPopulating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.isRadiology
              ? context.strings.radiologyCenterInfo
              : context.strings.labInformation,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.status == SettingsStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? context.strings.error),
              ),
            );
          } else if (state.status == SettingsStatus.success ||
              state.labInfo != null) {
            _populateData(state);
          }
        },
        builder: (context, state) {
          if (state.labInfo == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                child: Column(
                  children: [
                    VerificationStatusCard(
                      isRadiology: widget.isRadiology,
                      year: state.labInfo!.verificationYear,
                    ),
                    SizedBox(height: 24.h),
                    LabInfoForm(
                      isRadiology: widget.isRadiology,
                      nameController: _nameController,
                      licenseController: _licenseController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      descriptionController: _descriptionController,
                    ),
                  ],
                ),
              ),
              if (_hasUnsavedChanges)
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 24.h,
                  child: UnsavedChangesBottomCard(
                    onCancel: _onCancel,
                    onSave: _onSave,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
