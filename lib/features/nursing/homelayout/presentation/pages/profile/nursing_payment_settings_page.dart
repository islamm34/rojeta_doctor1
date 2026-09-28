import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_event.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_bank_transfer_form.dart';
import 'widgets/nursing_mobile_wallet_form.dart';
import 'widgets/nursing_payment_action_bar.dart';
import 'widgets/nursing_payment_type_selector.dart';
import 'widgets/nursing_payout_schedule_card.dart';

class NursingPaymentSettingsPage extends StatefulWidget {
  const NursingPaymentSettingsPage({super.key});

  @override
  State<NursingPaymentSettingsPage> createState() =>
      _NursingPaymentSettingsPageState();
}

class _NursingPaymentSettingsPageState
    extends State<NursingPaymentSettingsPage> {
  late String _paymentType;
  late TextEditingController _accountHolderController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _ibanController;
  late TextEditingController _swiftController;
  late String _walletProvider;
  late TextEditingController _walletNumberController;
  late bool _isAutoPayout;
  late String _payoutSchedule;

  @override
  void initState() {
    super.initState();
    final settings =
        context.read<NursingBloc>().state.paymentSettings ??
        const NursingPaymentSettingsModel();

    _paymentType = settings.paymentType.isNotEmpty
        ? settings.paymentType
        : 'bank_transfer';
    _accountHolderController = TextEditingController(
      text: settings.accountHolderName,
    );
    _bankNameController = TextEditingController(text: settings.bankName);
    _accountNumberController = TextEditingController(
      text: settings.accountNumber,
    );
    _ibanController = TextEditingController(text: settings.iban);
    _swiftController = TextEditingController(text: settings.swiftCode);
    _walletProvider = settings.walletProvider.isNotEmpty
        ? settings.walletProvider
        : 'instapay';
    _walletNumberController = TextEditingController(
      text: settings.walletNumber,
    );
    _isAutoPayout = settings.isAutoPayout;
    _payoutSchedule = settings.payoutSchedule.isNotEmpty
        ? settings.payoutSchedule
        : 'weekly';
  }

  @override
  void dispose() {
    _accountHolderController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    _swiftController.dispose();
    _walletNumberController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updated = NursingPaymentSettingsModel(
      paymentType: _paymentType,
      accountHolderName: _accountHolderController.text.trim(),
      bankName: _bankNameController.text.trim(),
      accountNumber: _accountNumberController.text.trim(),
      iban: _ibanController.text.trim(),
      swiftCode: _swiftController.text.trim(),
      walletProvider: _walletProvider,
      walletNumber: _walletNumberController.text.trim(),
      isAutoPayout: _isAutoPayout,
      payoutSchedule: _payoutSchedule,
    );

    context.read<NursingBloc>().add(UpdateNursingPaymentSettingsEvent(updated));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.strings.settingsSavedSuccessfully),
        backgroundColor: const Color(0xFF059669),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.paymentSettings,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.payoutSettingsSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                  ),
                ),
                SizedBox(height: 16.h),
                NursingPaymentTypeSelector(
                  selectedType: _paymentType,
                  onTypeChanged: (type) => setState(() => _paymentType = type),
                ),
                SizedBox(height: 16.h),
                if (_paymentType == 'bank_transfer') ...[
                  NursingBankTransferForm(
                    accountHolderController: _accountHolderController,
                    bankNameController: _bankNameController,
                    accountNumberController: _accountNumberController,
                    ibanController: _ibanController,
                    swiftController: _swiftController,
                  ),
                ] else ...[
                  NursingMobileWalletForm(
                    selectedProvider: _walletProvider,
                    onProviderChanged: (p) =>
                        setState(() => _walletProvider = p),
                    walletNumberController: _walletNumberController,
                  ),
                ],
                SizedBox(height: 16.h),
                NursingPayoutScheduleCard(
                  isAutoPayout: _isAutoPayout,
                  onAutoPayoutChanged: (val) =>
                      setState(() => _isAutoPayout = val),
                  payoutSchedule: _payoutSchedule,
                  onScheduleChanged: (s) => setState(() => _payoutSchedule = s),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
      bottomSheet: NursingPaymentActionBar(
        onDiscard: () => Navigator.of(context).pop(),
        onSave: _saveChanges,
      ),
    );
  }
}
