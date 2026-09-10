import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import 'hospital_payment_method_toggle.dart';

class HospitalPaymentForm extends StatelessWidget {
  const HospitalPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.attach_money_rounded,
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.paymentDetails,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Payment Method Toggle
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.paymentMethod != c.paymentMethod,
            builder: (context, state) {
              return HospitalPaymentMethodToggle(
                paymentMethod: state.paymentMethod,
                onBankTransferSelected: () => context.read<AuthBloc>().add(
                  const PaymentMethodChangedEvent('bank'),
                ),
                onMobileWalletSelected: () => context.read<AuthBloc>().add(
                  const PaymentMethodChangedEvent('wallet'),
                ),
              );
            },
          ),

          SizedBox(height: 20.h),

          // Account Holder Name
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.accountHolderName != c.accountHolderName,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.accountHolderName.toUpperCase(),
                hintText: 'Ahmed Mohamed',
                onChanged: (val) => context.read<AuthBloc>().add(
                  AccountHolderNameChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Bank Name
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.bankName != c.bankName,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.bankName.toUpperCase(),
                hintText: 'Bank Masr',
                onChanged: (val) =>
                    context.read<AuthBloc>().add(BankNameChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Account Number
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.accountNumber != c.accountNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.accountNumber.toUpperCase(),
                hintText: '0000 0000 0000 0000',
                keyboardType: TextInputType.number,
                maxLength: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberInputFormatter(),
                ],
                onChanged: (val) => context.read<AuthBloc>().add(
                  AccountNumberChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Expiry Date + CVV row
          Row(
            children: [
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (p, c) => p.expiryDate != c.expiryDate,
                  builder: (context, state) {
                    return CustomTextField(
                      label: context.strings.expiryDate,
                      hintText: 'MM/YY',
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryDateInputFormatter(),
                      ],
                      onChanged: (val) => context.read<AuthBloc>().add(
                        ExpiryDateChangedEvent(val),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (p, c) => p.cvv != c.cvv,
                  builder: (context, state) {
                    return CustomTextField(
                      label: context.strings.cvv,
                      hintText: '• • •',
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      suffixIcon: const Icon(
                        Icons.help_outline,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onChanged: (val) =>
                          context.read<AuthBloc>().add(CvvChangedEvent(val)),
                    );
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Security note
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8F0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF2ECC71),
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.strings.yourPaymentDetailsAreSecure,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF27AE60),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonSpaceLength = i + 1;
      if (nonSpaceLength % 4 == 0 && nonSpaceLength != text.length) {
        buffer.write(' ');
      }
    }

    final formattedText = buffer.toString();
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
    }

    final formattedText = buffer.toString();
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
