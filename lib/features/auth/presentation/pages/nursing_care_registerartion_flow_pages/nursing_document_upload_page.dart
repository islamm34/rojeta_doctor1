// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeraion_steps_app_bar.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeration_steps_indicator.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/file_picker_helper.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../widgets/document_upload/terms_card.dart';
import '../../widgets/document_upload/next_steps_card.dart';
import '../../widgets/nursing_care_registerartion_flow_pages_widgets/nursing_upload_section.dart';

class NursingDocumentUploadPage extends StatelessWidget {
  const NursingDocumentUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<AuthBloc>(),
      child: const _NursingDocumentUploadView(),
    );
  }
}

class _NursingDocumentUploadView extends StatelessWidget {
  const _NursingDocumentUploadView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.loaded) {
          final phone = state.phone.isNotEmpty
              ? state.phone
              : state.organizationNumber;
          context.pushNamed(AppRoutes.verifyPhone, extra: {'phone': phone});
          context.read<AuthBloc>().add(const ResetAuthStatusEvent());
        } else if (state.status == AuthStatus.error) {
          if (state.message.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FCFF),
        appBar: RegisteraionStepsAppBar(stepText: 'Step 5 of 6'),
        body: SafeArea(
          child: Column(
            children: [
              RegisterationStepsIndicator(progress: 1.0),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  color: theme.colorScheme.primary,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  context.strings.documentUpload,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return NursingUploadSection(
                                  medicalLicensePicked:
                                      state.medicalLicensePath != null,
                                  certificatesPicked:
                                      state.certificatesPath != null,
                                  logoPicked: state.profileImagePath != null,
                                  nationalIdPicked:
                                      state.nationalIdPath != null,
                                  centerImagesPicked:
                                      state.organizationImagePath != null,
                                  onMedicalLicenseTap: () async {
                                    final file =
                                        await FilePickerHelper.pickFile();
                                    final path = file?.path;
                                    if (path != null) {
                                      context.read<AuthBloc>().add(
                                        PickMedicalLicenseEvent(path),
                                      );
                                    }
                                  },
                                  onCertificatesTap: () async {
                                    final file =
                                        await FilePickerHelper.pickFile();
                                    final path = file?.path;
                                    if (path != null) {
                                      context.read<AuthBloc>().add(
                                        PickCertificatesEvent(path),
                                      );
                                    }
                                  },
                                  onLogoTap: () async {
                                    final file =
                                        await FilePickerHelper.pickFile();
                                    final path = file?.path;
                                    if (path != null) {
                                      context.read<AuthBloc>().add(
                                        PickProfileImageEvent(path),
                                      );
                                    }
                                  },
                                  onNationalIdTap: () async {
                                    final file =
                                        await FilePickerHelper.pickFile();
                                    final path = file?.path;
                                    if (path != null) {
                                      context.read<AuthBloc>().add(
                                        PickNationalIdEvent(path),
                                      );
                                    }
                                  },
                                  onCenterImagesTap: () async {
                                    final file =
                                        await FilePickerHelper.pickFile();
                                    final path = file?.path;
                                    if (path != null) {
                                      context.read<AuthBloc>().add(
                                        PickOrganizationImageEvent(path),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      const TermsCard(),
                      SizedBox(height: 24.h),
                      const NextStepsCard(),
                      SizedBox(height: 32.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: context.strings.back,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              textStyle: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                if (context.canPop) context.pop();
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final isLoading =
                                    state.status == AuthStatus.loading;
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.r),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF005BEA),
                                        Color(0xFF00C6FB),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: CustomElevatedButton(
                                    text: context.strings.completeRegistration,
                                    backgroundColor: Colors.transparent,
                                    isLoading: isLoading,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            context.read<AuthBloc>().add(
                                              const SubmitRegistrationEvent(),
                                            );
                                          },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      RichText(
                        text: TextSpan(
                          text: '${context.strings.alreadyHaveAccount} ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: context.strings.loginHere,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushReplacementNamed(AppRoutes.login);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
