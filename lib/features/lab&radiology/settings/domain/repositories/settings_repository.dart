import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/general_settings_model.dart';
import '../../data/models/lab_info_model.dart';
import '../../data/models/lab_profile_model.dart';
import '../../data/models/working_hours_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, LabProfileModel>> getLabProfile();
  Future<Either<Failure, void>> updateLabProfile(LabProfileModel profile);
  Future<Either<Failure, GeneralSettingsModel>> getGeneralSettings();
  Future<Either<Failure, void>> updateGeneralSettings(GeneralSettingsModel settings);
  Future<Either<Failure, LabInfoModel>> getLabInfo();
  Future<Either<Failure, void>> updateLabInfo(LabInfoModel info);
  Future<Either<Failure, WorkingHoursModel>> getWorkingHours();
  Future<Either<Failure, void>> updateWorkingHours(WorkingHoursModel workingHours);
}
