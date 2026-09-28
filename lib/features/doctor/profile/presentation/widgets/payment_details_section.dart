import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';

import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';

class PaymentDetailsSection extends StatelessWidget {
  final ProfileModel profile;
  final TextEditingController? accountHolderController;
  final TextEditingController? bankNameController;
  final TextEditingController? accountNumberController;

  const PaymentDetailsSection({
    super.key,
    required this.profile,
    this.accountHolderController,
    this.bankNameController,
    this.accountNumberController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paymentType = profile.paymentDetails.paymentType;
    final isBankTransfer = paymentType == 'bank_transfer';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.payment_outlined,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              context.strings.paymentDetails,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => context.read<ProfileBloc>().add(
                  const SwitchPaymentTypeEvent('bank_transfer'),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isBankTransfer
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withValues(alpha: 0.1),
                      width: isBankTransfer ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: isBankTransfer
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.strings.bankTransfer,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isBankTransfer
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.strings.directDepositToLocalBank,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => context.read<ProfileBloc>().add(
                  const SwitchPaymentTypeEvent('mobile_wallet'),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !isBankTransfer
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withValues(alpha: 0.1),
                      width: !isBankTransfer ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: !isBankTransfer
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.strings.mobileWallet,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: !isBankTransfer
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.strings.instantTransferToDigitalWallet,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (isBankTransfer) ...[
          CustomTextField(
            label: context.strings.accountHolderName,
            controller: accountHolderController,
            initialValue: accountHolderController == null
                ? profile.paymentDetails.accountHolderName
                : null,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.bankName,
            controller: bankNameController,
            initialValue: bankNameController == null
                ? profile.paymentDetails.bankName
                : null,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.accountNumber,
            controller: accountNumberController,
            initialValue: accountNumberController == null
                ? profile.paymentDetails.accountNumber
                : null,
            keyboardType: TextInputType.number,
            maxLength: 16,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ] else ...[
          CustomTextField(
            label: context.strings.mobileNumber,
            controller: accountNumberController,
            initialValue: accountNumberController == null
                ? profile.paymentDetails.accountNumber
                : null,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ],
    );
  }
}
