import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

import '../../../data/models/lab_service_model.dart';
import '../../bloc/services/lab_services_bloc.dart';
import 'widgets/add_service_form.dart';
import 'widgets/add_service_header_card.dart';

class AddLabServiceArgs {
  final UserType userType;
  final LabServiceModel? service;

  const AddLabServiceArgs({required this.userType, this.service});
}

class AddLabServicePage extends StatelessWidget {
  final UserType userType;
  final LabServiceModel? service;

  const AddLabServicePage({super.key, required this.userType, this.service});

  @override
  Widget build(BuildContext context) {
    final isRadiology = userType == UserType.radiologyCenter;
    final isEdit = service != null;
    final title = isEdit
        ? '${context.strings.edit} ${isRadiology ? context.strings.scans : context.strings.testName}'
        : (isRadiology
              ? context.strings.addNewScan
              : context.strings.addNewTest);

    return BlocProvider(
      create: (context) => injector<LabServicesBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(title), centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddServiceHeaderCard(userType: userType, isEdit: isEdit),
                SizedBox(height: 24.h),
                AddServiceForm(userType: userType, service: service),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
