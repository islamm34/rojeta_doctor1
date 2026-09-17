import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/branch_model.dart';

abstract class ManageBranchRepository {
  Future<Either<Failure, List<BranchModel>>> getBranches({UserType? userType});
  Future<Either<Failure, void>> addBranch(BranchModel branch, {UserType? userType});
  Future<Either<Failure, void>> deleteBranch(String branchId, {UserType? userType});
}
