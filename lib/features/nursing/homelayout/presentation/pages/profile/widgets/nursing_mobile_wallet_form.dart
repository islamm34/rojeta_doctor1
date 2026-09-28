import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import 'nursing_field_label.dart';
import 'nursing_text_field.dart';

class NursingMobileWalletForm extends StatelessWidget {
  final String selectedProvider;
  final ValueChanged<String> onProviderChanged;
  final TextEditingController walletNumberController;

  const NursingMobileWalletForm({
    super.key,
    required this.selectedProvider,
    required this.onProviderChanged,
    required this.walletNumberController,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final providers = [
      (id: 'instapay', name: 'InstaPay (IPA / IPN)'),
      (id: 'vodafone_cash', name: 'Vodafone Cash'),
      (id: 'orange_cash', name: 'Orange Cash'),
      (id: 'etisalat_cash', name: 'Etisalat Cash'),
      (id: 'we_pay', name: 'WE Pay'),
    ];

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
                Icons.account_balance_wallet_outlined,
                color: const Color(0xFF0F2D52),
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                strings.mobileWallet,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          NursingFieldLabel(text: 'WALLET PROVIDER'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: providers.any((p) => p.id == selectedProvider)
                    ? selectedProvider
                    : 'instapay',
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B),
                ),
                items: providers.map((p) {
                  return DropdownMenuItem<String>(
                    value: p.id,
                    child: Text(
                      p.name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) onProviderChanged(val);
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: strings.phoneNumber),
          NursingTextField(
            controller: walletNumberController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: '01XXXXXXXXX',
          ),
        ],
      ),
    );
  }
}
