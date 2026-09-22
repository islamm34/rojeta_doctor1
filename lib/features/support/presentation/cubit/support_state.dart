import 'package:equatable/equatable.dart';
import '../../data/models/support_contact_model.dart';

enum SupportStatus { initial, loading, success, failure }

class SupportState extends Equatable {
  final SupportStatus status;
  final SupportContactModel? contact;
  final String? errorMessage;

  const SupportState({
    this.status = SupportStatus.initial,
    this.contact,
    this.errorMessage,
  });

  SupportState copyWith({
    SupportStatus? status,
    SupportContactModel? contact,
    String? errorMessage,
  }) {
    return SupportState(
      status: status ?? this.status,
      contact: contact ?? this.contact,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contact, errorMessage];
}
