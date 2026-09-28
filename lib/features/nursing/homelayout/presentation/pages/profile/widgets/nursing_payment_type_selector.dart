import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingPaymentTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const NursingPaymentTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final isBankTransfer = selectedType == 'bank_transfer';

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTypeChanged('bank_transfer'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: isBankTransfer ? const Color(0xFFEFF6FF) : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isBankTransfer
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFE2E8F0),
                  width: isBankTransfer ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    color: isBankTransfer
                        ? const Color(0xFF2563EB)
                        : const Color(0xFF64748B),
                    size: 26.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    strings.bankTransfer,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: isBankTransfer
                          ? const Color(0xFF1E40AF)
                          : const Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    strings.directDepositToLocalBank,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: () => onTypeChanged('mobile_wallet'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: !isBankTransfer ? const Color(0xFFEFF6FF) : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: !isBankTransfer
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFE2E8F0),
                  width: !isBankTransfer ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: !isBankTransfer
                        ? const Color(0xFF2563EB)
                        : const Color(0xFF64748B),
                    size: 26.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    strings.mobileWallet,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: !isBankTransfer
                          ? const Color(0xFF1E40AF)
                          : const Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    strings.instantTransferToDigitalWallet,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
