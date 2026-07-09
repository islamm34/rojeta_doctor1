import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsSection extends StatelessWidget {
  final ProfileModel profile;

  const PaymentDetailsSection({super.key, required this.profile});

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
            Icon(Icons.payment_outlined, color: theme.colorScheme.primary, size: 20),
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
                onTap: () => context.read<ProfileBloc>().add(const SwitchPaymentTypeEvent('bank_transfer')),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.1),
                      width: isBankTransfer ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance, color: isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant),
                      const SizedBox(height: 8),
                      Text(
                        context.strings.bankTransfer,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
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
                onTap: () => context.read<ProfileBloc>().add(const SwitchPaymentTypeEvent('mobile_wallet')),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.1),
                      width: !isBankTransfer ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance_wallet, color: !isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant),
                      const SizedBox(height: 8),
                      Text(
                        context.strings.mobileWallet,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: !isBankTransfer ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
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
            initialValue: profile.paymentDetails.accountHolderName,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.bankName,
            initialValue: profile.paymentDetails.bankName,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.accountNumber,
            initialValue: profile.paymentDetails.accountNumber,
            keyboardType: TextInputType.number,
          ),
        ] else ...[
          // For mobile wallet, we might just need the phone number/wallet number
          CustomTextField(
            label: context.strings.mobileNumber,
            initialValue: profile.paymentDetails.accountNumber,
            keyboardType: TextInputType.phone,
          ),
        ]
      ],
    );
  }
}
