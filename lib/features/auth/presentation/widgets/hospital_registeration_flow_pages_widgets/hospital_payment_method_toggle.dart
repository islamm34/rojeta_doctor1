import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

/// Toggle between Bank Transfer and Mobile Wallet payment methods.
class HospitalPaymentMethodToggle extends StatelessWidget {
  final String paymentMethod;
  final VoidCallback onBankTransferSelected;
  final VoidCallback onMobileWalletSelected;

  const HospitalPaymentMethodToggle({
    super.key,
    required this.paymentMethod,
    required this.onBankTransferSelected,
    required this.onMobileWalletSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MethodCard(
            icon: Icons.account_balance_outlined,
            title: context.strings.bankTransfer,
            subtitle: context.strings.directDepositToLocalBank,
            isSelected: paymentMethod == 'bank',
            onTap: onBankTransferSelected,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _MethodCard(
            icon: Icons.wallet_outlined,
            title: context.strings.mobileWallet,
            subtitle: context.strings.instantTransferToDigitalWallet,
            isSelected: paymentMethod == 'wallet',
            onTap: onMobileWalletSelected,
          ),
        ),
      ],
    );
  }
}

class _MethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.grey.shade600,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
