import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../bloc/doctor_chat_bloc.dart';
import '../bloc/doctor_chat_event.dart';
import '../bloc/doctor_chat_state.dart';
import '../widgets/conversation_list_item.dart';

class DoctorConversationsPage extends StatelessWidget {
  const DoctorConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injector<DoctorChatBloc>()..add(const FetchConversationsEvent()),
      child: const _DoctorConversationsView(),
    );
  }
}

class _DoctorConversationsView extends StatelessWidget {
  const _DoctorConversationsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(context.strings.messages),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: BlocBuilder<DoctorChatBloc, DoctorChatState>(
        builder: (context, state) {
          if (state.status == DoctorChatStatus.loading &&
              state.conversations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DoctorChatStatus.failure &&
              state.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? context.strings.somethingWentWrong),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<DoctorChatBloc>()
                          .add(const FetchConversationsEvent());
                    },
                    child: Text(context.strings.retry),
                  ),
                ],
              ),
            );
          }

          if (state.conversations.isEmpty) {
            return Center(
              child: Text(
                context.strings.noDataAvailable,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<DoctorChatBloc>()
                  .add(const FetchConversationsEvent());
            },
            child: ListView.separated(
              itemCount: state.conversations.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return ConversationListItem(
                  conversation: conversation,
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.doctorChatMessages,
                      extra: conversation,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
