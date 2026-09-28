import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import 'nursing_field_label.dart';
import 'nursing_text_field.dart';

class NursingBankTransferForm extends StatelessWidget {
  final TextEditingController accountHolderController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController ibanController;
  final TextEditingController swiftController;

  const NursingBankTransferForm({
    super.key,
    required this.accountHolderController,
    required this.bankNameController,
    required this.accountNumberController,
    required this.ibanController,
    required this.swiftController,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance,
                color: const Color(0xFF0F2D52),
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                strings.bankTransfer,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          NursingFieldLabel(text: strings.accountHolderName),
          NursingTextField(
            controller: accountHolderController,
            hintText: 'e.g., Nursing Care Services LLC',
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: strings.bankName),
          NursingTextField(
            controller: bankNameController,
            hintText: 'e.g., National Bank of Egypt (NBE)',
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: strings.accountNumber),
          NursingTextField(
            controller: accountNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: '12345678901234',
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: 'IBAN NUMBER'),
          NursingTextField(
            controller: ibanController,
            hintText: 'EG0000000000000000000000000',
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: 'SWIFT / BIC CODE'),
          NursingTextField(
            controller: swiftController,
            hintText: 'e.g., NBEGEGCX',
          ),
        ],
      ),
    );
  }
}
