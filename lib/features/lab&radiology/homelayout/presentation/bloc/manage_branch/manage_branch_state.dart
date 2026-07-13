import 'package:equatable/equatable.dart';
import '../../../data/models/branch_model.dart';

enum ManageBranchStatus { initial, loading, success, failure }

class ManageBranchState extends Equatable {
  final ManageBranchStatus status;
  final List<BranchModel> branches;
  final String? errorMessage;
  final int totalBranches;
  final int activeCollections;

  const ManageBranchState({
    this.status = ManageBranchStatus.initial,
    this.branches = const [],
    this.errorMessage,
    this.totalBranches = 0,
    this.activeCollections = 0,
  });

  ManageBranchState copyWith({
    ManageBranchStatus? status,
    List<BranchModel>? branches,
    String? errorMessage,
    int? totalBranches,
    int? activeCollections,
  }) {
    return ManageBranchState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      errorMessage: errorMessage,
      totalBranches: totalBranches ?? this.totalBranches,
      activeCollections: activeCollections ?? this.activeCollections,
    );
  }

  ManageBranchState copyWithClearError({
    ManageBranchStatus? status,
    List<BranchModel>? branches,
    int? totalBranches,
    int? activeCollections,
  }) {
    return ManageBranchState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      errorMessage: null,
      totalBranches: totalBranches ?? this.totalBranches,
      activeCollections: activeCollections ?? this.activeCollections,
    );
  }

  ManageBranchState copyWithError({
    required String errorMessage,
    ManageBranchStatus? status,
    List<BranchModel>? branches,
    int? totalBranches,
    int? activeCollections,
  }) {
    return ManageBranchState(
      status: status ?? ManageBranchStatus.failure,
      branches: branches ?? this.branches,
      errorMessage: errorMessage,
      totalBranches: totalBranches ?? this.totalBranches,
      activeCollections: activeCollections ?? this.activeCollections,
    );
  }

  @override
  List<Object?> get props => [
        status,
        branches,
        errorMessage,
        totalBranches,
        activeCollections,
      ];
}
