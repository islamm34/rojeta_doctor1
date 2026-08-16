import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeration_steps_indicator.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../core/di/injector.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../../bloc/auth_event.dart';
import '../../widgets/document_upload/upload_item_card.dart';
import '../../widgets/document_upload/terms_card.dart';
import '../../widgets/document_upload/next_steps_card.dart';
import '../../../../../core/utils/file_picker_helper.dart';
import '../../widgets/registeraion_steps_app_bar.dart';

class DocumentUploadPage extends StatelessWidget {
  const DocumentUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<AuthBloc>(),
      child: const _DocumentUploadView(),
    );
  }
}

class _DocumentUploadView extends StatelessWidget {
  const _DocumentUploadView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.loaded) {
          context.pushNamed(
            AppRoutes.verifyPhone,
          );
          context.read<AuthBloc>().add(const ResetAuthStatusEvent());
        } else if (state.status == AuthStatus.error) {
          if (state.message != null && state.message!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: RegisteraionStepsAppBar(stepText: context.strings.step4Of5),
      body: SafeArea(
        child: Column(
          children: [
            RegisterationStepsIndicator(progress: 0.8),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    // Main White Card for Uploads
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.strings.documentUpload,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                    ),
                                    Text(
                                      context.strings.documentUploadDesc,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: Colors.grey.shade500,
                                            fontSize: 11.sp,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  UploadItemCard(
                                    title: context.strings.medicalLicense,
                                    subtitle: context.strings.uploadClearCopy,
                                    isPicked: state.medicalLicensePath != null,
                                    onTap: () async {
                                      final file =
                                          await FilePickerHelper.pickFile();
                                      final path = file?.path;
                                      if (path != null) {
                                        context.read<AuthBloc>().add(
                                          PickMedicalLicenseEvent(path),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  UploadItemCard(
                                    title: context.strings.certificates,
                                    subtitle:
                                        context.strings.optionalButRecommended,
                                    isPicked: state.certificatesPath != null,
                                    onTap: () async {
                                      final file =
                                          await FilePickerHelper.pickFile();
                                      final path = file?.path;
                                      if (path != null) {
                                        context.read<AuthBloc>().add(
                                          PickCertificatesEvent(path),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  UploadItemCard(
                                    title: context.strings.nationalId,
                                    subtitle:
                                        context.strings.forVerificationPurposes,
                                    isPicked: state.nationalIdPath != null,
                                    onTap: () async {
                                      final file =
                                          await FilePickerHelper.pickFile();
                                      final path = file?.path;
                                      if (path != null) {
                                        context.read<AuthBloc>().add(
                                          PickNationalIdEvent(path),
                                        );
                                      }
                                    },
                                  ),
                                ],
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

                    // Buttons Row
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
                              if (context.canPop) {
                                context.pop();
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isValid = true;
                              final isLoading =
                                  state.status == AuthStatus.loading;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  gradient: isValid
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF005BEA),
                                            Color(0xFF00C6FB),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      : null,
                                  color: isValid ? null : Colors.grey.shade300,
                                ),
                                child: CustomElevatedButton(
                                  text: context.strings.completeRegistration,
                                  isLoading: isLoading,
                                  onPressed: (isValid && !isLoading)
                                      ? () {
                                          context.read<AuthBloc>().add(
                                                const SubmitRegistrationEvent(),
                                              );
                                        }
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Footer Login
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
