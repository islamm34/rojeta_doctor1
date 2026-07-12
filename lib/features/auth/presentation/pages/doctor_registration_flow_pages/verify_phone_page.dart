import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeraion_steps_app_bar.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../widgets/registeration_steps_indicator.dart';
import '../../widgets/verify_phone/verify_phone_card.dart';

class VerifyPhonePage extends StatelessWidget {
  final String? comefrom;

  const VerifyPhonePage({super.key, this.comefrom});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AuthBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FCFF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.selectedType != current.selectedType,
            builder: (context, state) {
              final isFiveSteps =
                  state.selectedType == UserType.doctor ||
                  state.selectedType == UserType.hospital;
              final stepText = isFiveSteps
                  ? context.strings.step5Of5
                  : 'Step 6 of 6';
              return RegisteraionStepsAppBar(stepText: stepText);
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegisterationStepsIndicator(progress: 1.0),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      VerifyPhoneCard(comefrom: comefrom),
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
