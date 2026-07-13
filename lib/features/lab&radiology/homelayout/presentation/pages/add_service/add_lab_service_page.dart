import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import 'widgets/add_service_header_card.dart';
import 'widgets/add_service_form.dart';

class AddLabServicePage extends StatelessWidget {
  final UserType userType;

  const AddLabServicePage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final isRadiology = userType == UserType.radiologyCenter;
    return Scaffold(
      appBar: AppBar(
        title: Text(isRadiology ? context.strings.addNewScan : context.strings.addNewTest),
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
    );
  }
}
