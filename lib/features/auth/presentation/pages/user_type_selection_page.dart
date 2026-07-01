import 'package:flutter/material.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import 'widgets/user_type_card.dart';

enum UserType { doctor, patient }

class UserTypeSelectionPage extends StatefulWidget {
  const UserTypeSelectionPage({super.key});

  @override
  State<UserTypeSelectionPage> createState() => _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState extends State<UserTypeSelectionPage> {
  UserType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              40.ver,
              Text(
                strings.chooseTypeTitle,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              12.ver,
              Text(
                strings.chooseTypeSubtitle,
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              48.ver,
              UserTypeCard(
                title: strings.doctor,
                description: strings.doctorDesc,
                icon: Icons.medical_services_outlined,
                isSelected: _selectedType == UserType.doctor,
                onTap: () {
                  setState(() {
                    _selectedType = UserType.doctor;
                  });
                },
              ),
              20.ver,
              UserTypeCard(
                title: strings.patient,
                description: strings.patientDesc,
                icon: Icons.person_outline_rounded,
                isSelected: _selectedType == UserType.patient,
                onTap: () {
                  setState(() {
                    _selectedType = UserType.patient;
                  });
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                text: strings.continueButton,
                onPressed: _selectedType == null
                    ? () {}
                    : () {
                        context.pushNamed(
                          AppRoutes.login,
                          extra: _selectedType,
                        );
                      },
                backgroundColor: _selectedType == null
                    ? colors.primary.withValues(alpha: 0.5)
                    : colors.primary,
              ),
              20.ver,
            ],
          ),
        ),
      ),
    );
  }
}
