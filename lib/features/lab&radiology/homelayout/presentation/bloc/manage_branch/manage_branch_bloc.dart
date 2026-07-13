import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_branch_event.dart';
import 'manage_branch_state.dart';
import '../../../data/models/branch_model.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';

class ManageBranchBloc extends Bloc<ManageBranchEvent, ManageBranchState> {
  ManageBranchBloc() : super(const ManageBranchState()) {
    on<LoadBranchesEvent>(_onLoadBranches);
    on<DeleteBranchEvent>(_onDeleteBranch);
    on<AddBranchEvent>(_onAddBranch);
  }

  Future<void> _onLoadBranches(LoadBranchesEvent event, Emitter<ManageBranchState> emit) async {
    emit(state.copyWithClearError(status: ManageBranchStatus.loading));
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy mock data for UI building
    final List<BranchModel> dummyBranches = [
      BranchModel(
        id: '1',
        name: event.userType == UserType.radiologyCenter ? 'Central Diagnostic Hub' : 'Main Lab Hub',
        address: '452 Medical Plaza, Healthcare District\nDowntown, City Center',
        phone: '+20123-567',
        workingHours: '07:00 AM - 09:00 PM (Daily)',
        isHomeCollectionAvailable: true,
        imageUrl: 'https://via.placeholder.com/400x200.png?text=Map',
      ),
      BranchModel(
        id: '2',
        name: event.userType == UserType.radiologyCenter ? 'Westside Specialized Clinic' : 'Westside Blood Lab',
        address: '892 Ocean Blvd, West Wing\nMarina District',
        phone: '+1 (555) 444-2211',
        workingHours: '24/7 Operations',
        isHomeCollectionAvailable: true,
        imageUrl: 'https://via.placeholder.com/400x200.png?text=Map',
      ),
    ];

    emit(state.copyWithClearError(
      status: ManageBranchStatus.success,
      branches: dummyBranches,
      totalBranches: 12, // From design
      activeCollections: 8, // From design
    ));
  }

  Future<void> _onDeleteBranch(DeleteBranchEvent event, Emitter<ManageBranchState> emit) async {
    // Optimistic delete
    final updatedBranches = state.branches.where((b) => b.id != event.branchId).toList();
    
    emit(state.copyWithClearError(
      branches: updatedBranches,
      totalBranches: state.totalBranches - 1,
    ));
    // Simulated API call here
  }

  Future<void> _onAddBranch(AddBranchEvent event, Emitter<ManageBranchState> emit) async {
    // Optimistic add
    final updatedBranches = List<BranchModel>.from(state.branches)..add(event.branch);
    
    emit(state.copyWithClearError(
      branches: updatedBranches,
      totalBranches: state.totalBranches + 1,
    ));
    // Simulated API call here
  }
}
