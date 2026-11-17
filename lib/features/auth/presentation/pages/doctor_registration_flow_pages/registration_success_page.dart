import 'package:flutter/material.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/local/user_hive_helper.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/registration_status_model.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../../widgets/registration_success/contact_us_section.dart';
import '../../widgets/registration_success/registration_status_header.dart';
import '../../widgets/registration_success/request_number_section.dart';
import '../../widgets/registration_success/request_summary_card.dart';
import '../../widgets/registration_success/whats_next_card.dart';

class RegistrationSuccessPage extends StatelessWidget {
  final RegistrationStatusModel? statusModel;

  const RegistrationSuccessPage({super.key, this.statusModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = injector.isRegistered<AuthBloc>()
        ? injector<AuthBloc>().state
        : const AuthState();
    final savedUser = UserHiveHelper.getUser();

    final effectiveDoctorName = (statusModel?.doctorName.isNotEmpty == true)
        ? statusModel!.doctorName
        : (authState.fullName.isNotEmpty
            ? authState.fullName
            : (savedUser?.name?.isNotEmpty == true
                ? savedUser!.name!
                : (authState.organizationName.isNotEmpty
                    ? authState.organizationName
                    : 'علي عبدالعزيز')));

    final effectivePhone = (statusModel?.phoneNumber.isNotEmpty == true)
        ? statusModel!.phoneNumber
        : (authState.phone.isNotEmpty
            ? authState.phone
            : (savedUser?.phone?.isNotEmpty == true
                ? savedUser!.phone!
                : (authState.organizationNumber.isNotEmpty
                    ? authState.organizationNumber
                    : '01111111111')));

    final effectiveDocs = (statusModel?.uploadedDocuments.isNotEmpty == true)
        ? statusModel!.uploadedDocuments
        : const ['مثال', 'مثال', 'مثال'];

    final effectiveRequestNumber =
        (statusModel?.requestNumber.isNotEmpty == true)
            ? statusModel!.requestNumber
            : (savedUser?.id != null
                ? '#DRV${savedUser!.id.toString().padLeft(6, '0')}'
                : '#DRV137825');

    final effectiveModel = RegistrationStatusModel(
      requestNumber: effectiveRequestNumber,
      status: 'pending',
      doctorName: effectiveDoctorName,
      phoneNumber: effectivePhone,
      isPhoneVerified: true,
      uploadedDocuments: effectiveDocs,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RegistrationStatusHeader(),
              SizedBox(height: 24.h),
              // Main White Card containing Summary, Items and What's Next
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RequestSummaryCard(statusModel: effectiveModel),
                    SizedBox(height: 14.h),
                    const WhatsNextCard(),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              RequestNumberSection(requestNumber: effectiveRequestNumber),
              SizedBox(height: 24.h),
              const ContactUsSection(),
              SizedBox(height: 28.h),
              // Return to Login Screen Button (matches user design exactly: clean white card with shadow, no green border)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () {
                      context.pushNamedAndRemoveUntil(
                        AppRoutes.login,
                        predicate: (route) => false,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.strings.returnToLoginPage,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF009688),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.home_outlined,
                              color: const Color(0xFF009688),
                              size: 24.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                children: [
                  Text(
                    '🙏 ${context.strings.thankYouForJoining}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.strings.lookForwardToWorkingWithYou,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF10B981).withValues(alpha: 0.8),
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Privacy / Terms bottom alert banner
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFFDC2626),
                      size: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'اكمالك للطلب يعني اطلاعك على سياسة الخصوصية والشروط والأحكام',
                        style: TextStyle(
                          color: const Color(0xFF0D9488),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
