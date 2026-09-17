import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

import '../../bloc/services/lab_services_bloc.dart';
import 'widgets/add_service_form.dart';
import 'widgets/add_service_header_card.dart';

class AddLabServicePage extends StatelessWidget {
  final UserType userType;

  const AddLabServicePage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final isRadiology = userType == UserType.radiologyCenter;
    return BlocProvider(
      create: (context) => injector<LabServicesBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isRadiology
                ? context.strings.addNewScan
                : context.strings.addNewTest,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddServiceHeaderCard(userType: userType),
                SizedBox(height: 24.h),
                AddServiceForm(userType: userType),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
