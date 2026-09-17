import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../auth/data/models/user_type_model.dart';
import '../../../../data/models/create_lab_service_model.dart';
import '../../../../data/models/lab_service_model.dart';
import '../../../bloc/services/lab_services_bloc.dart';
import '../../../bloc/services/lab_services_event.dart';
import '../../../bloc/services/lab_services_state.dart';
import 'add_service_text_field.dart';

class AddServiceForm extends StatefulWidget {
  final UserType userType;
  final LabServiceModel? service;

  const AddServiceForm({super.key, required this.userType, this.service});

  @override
  State<AddServiceForm> createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _priceController;
  late final TextEditingController _turnaroundTimeController;
  late final TextEditingController _preparationsController;

  late bool _isHomeCollection;

  @override
  void initState() {
    super.initState();
    final service = widget.service;
    _nameController = TextEditingController(text: service?.name ?? '');
    _categoryController = TextEditingController(text: service?.category ?? '');
    _priceController = TextEditingController(
      text: service?.price != null
          ? (service!.price! % 1 == 0
                ? service.price!.toInt().toString()
                : service.price!.toString())
          : '',
    );
    _turnaroundTimeController = TextEditingController(
      text: service?.turnaroundTime ?? '',
    );
    _preparationsController = TextEditingController(
      text: service?.instructions ?? service?.description ?? '',
    );
    _isHomeCollection = service?.isHomeCollectionAvailable ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _turnaroundTimeController.dispose();
    _preparationsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final model = CreateLabServiceModel(
        name: _nameController.text.trim(),
        category: _categoryController.text.trim(),
        price: price,
        turnaroundTime: _turnaroundTimeController.text.trim(),
        preparations: _preparationsController.text.trim(),
        isHomeCollectionAvailable: _isHomeCollection,
      );

      final serviceId = widget.service?.id;
      if (serviceId != null && serviceId.isNotEmpty) {
        context.read<LabServicesBloc>().add(
          UpdateLabServiceEvent(serviceId, model, widget.userType),
        );
      } else {
        context.read<LabServicesBloc>().add(
          CreateLabServiceEvent(model, widget.userType),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRadiology = widget.userType == UserType.radiologyCenter;
    return BlocConsumer<LabServicesBloc, LabServicesState>(
      listener: (context, state) {
        if (state.status == LabServicesStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(context.strings.saveService)));
          Navigator.of(context).pop(true);
        } else if (state.status == LabServicesStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == LabServicesStatus.loading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddServiceTextField(
                controller: _nameController,
                label: isRadiology
                    ? context.strings.scanName
                    : context.strings.testName,
                icon: Icons.title,
              ),
              SizedBox(height: 16.h),
              AddServiceTextField(
                controller: _categoryController,
                label: context.strings.category,
                icon: Icons.category,
              ),
              SizedBox(height: 16.h),
              AddServiceTextField(
                controller: _priceController,
                label: context.strings.priceEgp,
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              AddServiceTextField(
                controller: _turnaroundTimeController,
                label: context.strings.turnaroundTimeLabel,
                icon: Icons.timer,
              ),
              SizedBox(height: 16.h),
              AddServiceTextField(
                controller: _preparationsController,
                label: context.strings.preparationsOptional,
                icon: Icons.info_outline,
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              SwitchListTile(
                title: Text(context.strings.homeCollectionAvailable),
                value: _isHomeCollection,
                activeThumbColor: context.colors.primary,
                onChanged: (val) => setState(() => _isHomeCollection = val),
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          context.strings.saveService,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
