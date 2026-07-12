import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../widgets/add_clinic/clinic_basic_info_section.dart';
import '../widgets/add_clinic/clinic_photos_section.dart';
import '../widgets/add_clinic/consultation_time_section.dart';
import '../widgets/add_clinic/working_hours_section.dart';
import '../widgets/add_clinic/clinic_services_pricing_section.dart';
import '../widgets/add_clinic/additional_services_pricing_section.dart';

class AddClinicPage extends StatelessWidget {
  const AddClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddClinicView();
  }
}

class AddClinicView extends StatelessWidget {
  const AddClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(strings.addClinicTitle),
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
                    child: Container(color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClinicBasicInfoSection(),
                      SizedBox(height: 24),
                      ClinicPhotosSection(),
                      SizedBox(height: 24),
                      ConsultationTimeSection(),
                      SizedBox(height: 24),
                      WorkingHoursSection(),
                      SizedBox(height: 24),
                      ClinicServicesPricingSection(),
                      SizedBox(height: 24),
                      AdditionalServicesPricingSection(),
                    ],
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
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(strings.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
