import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../models/branch_model.dart';

abstract class ManageBranchRemoteDataSource {
  Future<List<BranchModel>> getBranches({UserType? userType});
  Future<void> addBranch(BranchModel branch, {UserType? userType});
  Future<void> deleteBranch(String branchId, {UserType? userType});
}

class ManageBranchRemoteDataSourceImpl implements ManageBranchRemoteDataSource {
  final ApiConsumer apiConsumer;

  ManageBranchRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<BranchModel>> getBranches({UserType? userType}) async {
    final response = await apiConsumer.get(Endpoints.getBranches);

    List<dynamic> list = [];
    if (response is List) {
      list = response;
    } else if (response is Map<String, dynamic>) {
      if (response['data'] is List) {
        list = response['data'] as List<dynamic>;
      } else if (response['branches'] is List) {
        list = response['branches'] as List<dynamic>;
      }
    }

    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => BranchModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> addBranch(BranchModel branch, {UserType? userType}) async {
    await apiConsumer.post(Endpoints.addBranch, data: branch.toJson());
  }

  @override
  Future<void> deleteBranch(String branchId, {UserType? userType}) async {
    await apiConsumer.delete(Endpoints.deleteBranch(branchId));
  }
}
