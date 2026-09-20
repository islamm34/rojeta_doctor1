import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';

class SettingsHelpCenterSheet extends StatelessWidget {
  const SettingsHelpCenterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsHelpCenterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final faqs = [
      {
        'q': 'How do I manage my clinic schedule?',
        'a':
            'You can go to the Schedule Management screen from your home dashboard to set working days, time slots, and vacations.',
      },
      {
        'q': 'How are cash payments confirmed?',
        'a':
            'When a patient arrives with a cash booking, open the appointment details and tap "Confirm Cash Payment" once payment is received.',
      },
      {
        'q': 'When do I receive my earnings payout?',
        'a':
            'Payouts are calculated from completed bookings and processed according to your payout cycle in Financial Management.',
      },
      {
        'q': 'How do I update my profile details?',
        'a':
            'Navigate to the Profile tab to edit your medical title, bio, consultation fees, and clinic locations.',
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.helpCenter,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: faqs.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(bottom: 12),
                  title: Text(
                    faq['q'] ?? '',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [
                    Text(
                      faq['a'] ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          CustomElevatedButton(
            text: context.strings.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
