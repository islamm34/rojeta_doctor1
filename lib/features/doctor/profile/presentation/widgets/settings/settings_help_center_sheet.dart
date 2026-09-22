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
        'q': context.strings.faqManageScheduleQuestion,
        'a': context.strings.faqManageScheduleAnswer,
      },
      {
        'q': context.strings.faqCashPaymentsQuestion,
        'a': context.strings.faqCashPaymentsAnswer,
      },
      {
        'q': context.strings.faqEarningsPayoutQuestion,
        'a': context.strings.faqEarningsPayoutAnswer,
      },
      {
        'q': context.strings.faqUpdateProfileQuestion,
        'a': context.strings.faqUpdateProfileAnswer,
      },
    ];

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
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
      ),
    );
  }
}
