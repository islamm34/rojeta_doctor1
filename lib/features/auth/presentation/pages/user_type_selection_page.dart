import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../core/di/injector.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/user_type_selection/user_type_card.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<AuthBloc>(),
      child: const _UserTypeSelectionView(),
    );
  }
}

class _UserTypeSelectionView extends StatelessWidget {
  const _UserTypeSelectionView();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context: context);
    final theme = Theme.of(context);

    final List<UserTypeModel> accountTypes = [
      UserTypeModel(
        type: UserType.doctor,
        titleKey: context.strings.doctor,
        imagePath: AppConstants.doctorImage,
      ),
      UserTypeModel(
        type: UserType.hospital,
        titleKey: context.strings.hospital,
        imagePath: AppConstants.hospitalImage,
      ),
      UserTypeModel(
        type: UserType.radiologyCenter,
        titleKey: context.strings.radiologyCenter,
        imagePath: AppConstants.radiologyImage,
      ),
      UserTypeModel(
        type: UserType.laboratory,
        titleKey: context.strings.laboratory,
        imagePath: AppConstants.labImage,
      ),
      UserTypeModel(
        type: UserType.nursingCareProviders,
        titleKey: context.strings.nursingCareProviders,
        imagePath: AppConstants.nursingImage,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (context.canPop) {
              context.pop();
            }
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.strings.createAccount,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18.sp,
              ),
            ),
            Text(
              context.strings.step1Of5,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: 0.2, // Step 1 of 5
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
              minHeight: 4.h,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo and Headings
                    Image.asset(
                      AppConstants.rLogo,
                      height: 50.h,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      context.strings.joinRujeta,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.strings.startProvidingQualityHealthcareServices,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),

                    // Account Type Selection
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        context.strings.selectYourAccountType,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final selectedType = state.selectedType;
                        return Wrap(
                          spacing: 16.w,
                          runSpacing: 16.h,
                          children: accountTypes.map((typeModel) {
                            final isNursing = typeModel.type == UserType.nursingCareProviders;
                            final cardWidth = isNursing
                                ? double.infinity
                                : (ScreenUtil.screenWidth - 40.w - 16.w) / 2;

                            return SizedBox(
                              width: cardWidth,
                              height: 110.h, // Fixed height for cards
                              child: UserTypeCard(
                                title: typeModel.titleKey,
                                imagePath: typeModel.imagePath,
                                isSelected: selectedType == typeModel.type,
                                onTap: () {
                                  context.read<AuthBloc>().add(SelectUserTypeEvent(typeModel.type));
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    SizedBox(height: 40.h),

                    // Next Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final selectedType = state.selectedType;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: CustomElevatedButton(
                            text: context.strings.next,
                            backgroundColor: Colors.transparent, // Let gradient show through
                            onPressed: () {
                              if (selectedType != null) {
                                context.pushNamed(AppRoutes.basicInformation);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please select an account type')),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 24.h),

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
    );
  }
}
