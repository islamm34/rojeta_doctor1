import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../main.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../doctor/chat/data/models/doctor_chat_models.dart';
import '../../../../../support/presentation/cubit/support_cubit.dart';
import '../../../../../support/presentation/cubit/support_state.dart';
import 'widgets/support_chat_tile.dart';
import 'widgets/support_contact_tile.dart';
import 'widgets/support_sheet_header.dart';

class SettingsContactSupportSheet extends StatelessWidget {
  const SettingsContactSupportSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsContactSupportSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<SupportCubit>()..fetchSupportContact(),
      child: const _SettingsContactSupportSheetContent(),
    );
  }
}

class _SettingsContactSupportSheetContent extends StatelessWidget {
  const _SettingsContactSupportSheetContent();

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label: $text'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _makeCall(BuildContext context, String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanPhone);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _copyToClipboard(context, phone, context.strings.phoneHotline);
      }
    } catch (_) {
      if (context.mounted) {
        _copyToClipboard(context, phone, context.strings.phoneHotline);
      }
    }
  }

  Future<void> _sendEmail(BuildContext context, String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email.trim(),
      queryParameters: {'subject': 'Support Inquiry - Rojeta Doctor'},
    );
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _copyToClipboard(context, email, context.strings.emailSupport);
      }
    } catch (_) {
      if (context.mounted) {
        _copyToClipboard(context, email, context.strings.emailSupport);
      }
    }
  }

  Future<void> _openAdminChat(BuildContext context, SupportState state) async {
    final cubit = context.read<SupportCubit>();
    final navState = RojetaDoctorApp.navigatorKey.currentState;

    Navigator.of(context).pop();

    final adminConversation = await cubit.getAdminConversation();

    final resolvedConversation = DoctorConversationModel(
      id: adminConversation.id.isNotEmpty
          ? adminConversation.id
          : 'admin_support',
      patientId: adminConversation.patientId.isNotEmpty
          ? adminConversation.patientId
          : 'admin',
      patientName: state.contact?.adminName ?? 'Rojeta Support Team',
      patientAvatar:
          state.contact?.adminAvatar ?? adminConversation.patientAvatar,
      lastMessage: adminConversation.lastMessage,
      lastMessageTime: adminConversation.lastMessageTime,
      unreadCount: 0,
    );

    navState?.pushNamed(
      AppRoutes.doctorChatMessages,
      arguments: resolvedConversation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: BlocBuilder<SupportCubit, SupportState>(
            builder: (context, state) {
              final email = state.contact?.email ?? 'support@rojeta.com';
              final phone = state.contact?.phone ?? '+20 100 000 0000';
              final hours =
                  state.contact?.availableHours ?? '9:00 AM - 6:00 PM';
              final responseTime = state.contact?.averageResponseTime != null
                  ? 'Average response time: ${state.contact!.averageResponseTime}'
                  : context.strings.averageResponseTime;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SupportSheetHeader(title: context.strings.contactSupport),
                  const SizedBox(height: 20),
                  SupportContactTile(
                    icon: Icons.email_outlined,
                    title: context.strings.emailSupport,
                    subtitle: email,
                    onTap: () => _sendEmail(context, email),
                  ),
                  const Divider(height: 16),
                  SupportContactTile(
                    icon: Icons.phone_outlined,
                    title: context.strings.phoneHotline,
                    subtitle: phone,
                    secondarySubtitle: hours,
                    onTap: () => _makeCall(context, phone),
                  ),
                  const Divider(height: 16),
                  SupportChatTile(
                    title: context.strings.liveSupportChat,
                    responseTimeText: responseTime,
                    onTap: () => _openAdminChat(context, state),
                  ),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    text: context.strings.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
