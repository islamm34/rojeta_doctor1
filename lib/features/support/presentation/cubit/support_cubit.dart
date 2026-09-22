import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../doctor/chat/data/models/doctor_chat_models.dart';
import '../../domain/repositories/i_support_repository.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final ISupportRepository repository;

  SupportCubit({required this.repository}) : super(const SupportState());

  Future<void> fetchSupportContact() async {
    emit(state.copyWith(status: SupportStatus.loading, errorMessage: null));
    try {
      final contact = await repository.getSupportContact();
      emit(state.copyWith(
        status: SupportStatus.success,
        contact: contact,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SupportStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<DoctorConversationModel> getAdminConversation() async {
    try {
      return await repository.getAdminConversation();
    } catch (_) {
      return DoctorConversationModel(
        id: 'admin_support',
        patientId: 'admin',
        patientName: state.contact?.adminName ?? 'Rojeta Support Team',
        patientAvatar: state.contact?.adminAvatar,
        lastMessage: 'Connecting to live support...',
        lastMessageTime: '',
        unreadCount: 0,
      );
    }
  }
}
