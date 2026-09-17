import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/manage_branch_repository.dart';
import 'manage_branch_event.dart';
import 'manage_branch_state.dart';

class ManageBranchBloc extends Bloc<ManageBranchEvent, ManageBranchState> {
  final ManageBranchRepository repository;

  ManageBranchBloc({required this.repository})
    : super(const ManageBranchState()) {
    on<LoadBranchesEvent>(_onLoadBranches);
    on<DeleteBranchEvent>(_onDeleteBranch);
    on<AddBranchEvent>(_onAddBranch);
  }

  Future<void> _onLoadBranches(
    LoadBranchesEvent event,
    Emitter<ManageBranchState> emit,
  ) async {
    emit(state.copyWithClearError(status: ManageBranchStatus.loading));

    final result = await repository.getBranches(userType: event.userType);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ManageBranchStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (branches) {
        final activeCount = branches
            .where((b) => b.isHomeCollectionAvailable == true)
            .length;
        emit(
          state.copyWithClearError(
            status: ManageBranchStatus.success,
            branches: branches,
            totalBranches: branches.length,
            activeCollections: activeCount,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteBranch(
    DeleteBranchEvent event,
    Emitter<ManageBranchState> emit,
  ) async {
    final updatedBranches = state.branches
        .where((b) => b.id != event.branchId)
        .toList();
    final activeCount = updatedBranches
        .where((b) => b.isHomeCollectionAvailable == true)
        .length;

    emit(
      state.copyWithClearError(
        branches: updatedBranches,
        totalBranches: updatedBranches.length,
        activeCollections: activeCount,
      ),
    );

    final result = await repository.deleteBranch(event.branchId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> _onAddBranch(
    AddBranchEvent event,
    Emitter<ManageBranchState> emit,
  ) async {
    emit(state.copyWith(status: ManageBranchStatus.loading));

    final result = await repository.addBranch(event.branch);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ManageBranchStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) {
        final updatedBranches = List.of(state.branches)..add(event.branch);
        final activeCount = updatedBranches
            .where((b) => b.isHomeCollectionAvailable == true)
            .length;
        emit(
          state.copyWithClearError(
            status: ManageBranchStatus.success,
            branches: updatedBranches,
            totalBranches: updatedBranches.length,
            activeCollections: activeCount,
          ),
        );
      },
    );
  }
}
