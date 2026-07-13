import 'package:equatable/equatable.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../../../data/models/branch_model.dart';

abstract class ManageBranchEvent extends Equatable {
  const ManageBranchEvent();

  @override
  List<Object> get props => [];
}

class LoadBranchesEvent extends ManageBranchEvent {
  final UserType userType;

  const LoadBranchesEvent({required this.userType});

  @override
  List<Object> get props => [userType];
}

class DeleteBranchEvent extends ManageBranchEvent {
  final String branchId;

  const DeleteBranchEvent({required this.branchId});

  @override
  List<Object> get props => [branchId];
}

class AddBranchEvent extends ManageBranchEvent {
  final BranchModel branch;

  const AddBranchEvent({required this.branch});

  @override
  List<Object> get props => [branch];
}
