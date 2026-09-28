import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeraion_steps_app_bar.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeration_steps_indicator.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/hospital_registeration_flow_pages_widgets/hospital_payment_form.dart';
import '../../widgets/radiology_registeration_flow_pages_widgets/radiology_home_sample_collection_form.dart';

class RadiologyHomeSampleCollectionPage extends StatelessWidget {
  const RadiologyHomeSampleCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<AuthBloc>(),
      child: const _RadiologyHomeSampleCollectionView(),
    );
  }
}

class _RadiologyHomeSampleCollectionView extends StatelessWidget {
  const _RadiologyHomeSampleCollectionView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: RegisteraionStepsAppBar(stepText: 'Step 4 of 6'),
      body: SafeArea(
        child: Column(
          children: [
            RegisterationStepsIndicator(progress: 0.67),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    const RadiologyHomeSampleCollectionForm(),
                    SizedBox(height: 24.h),
                    const HospitalPaymentForm(),
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: CustomElevatedButton(
                              text: context.strings.next,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              onPressed: () => context.pushNamed(
                                AppRoutes.radiologyDocumentUpload,
                              ),
                            ),
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
    );
  }
}
