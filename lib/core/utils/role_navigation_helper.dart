import 'package:flutter/material.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/local/user_data.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/flutter_secure_storage_helper.dart';
import 'package:rojeta_doctor/core/utils/snackbar_helper.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

class RoleNavigationHelper {
  static void navigateToRoleDashboard(
    BuildContext context, {
    UserData? user,
    UserType? fallbackType,
    bool clearStack = true,
  }) {
    final currentUser = user ?? UserHiveHelper.getUser();
    final role = (currentUser?.role != null && currentUser!.role!.isNotEmpty)
        ? currentUser.role!.toLowerCase().trim()
        : _roleFromUserType(fallbackType);

    if (role == 'hospital') {
      if (clearStack) {
        context.pushNamedAndRemoveUntil(AppRoutes.hospitalHome);
      } else {
        context.pushReplacementNamed(AppRoutes.hospitalHome);
      }
    } else if (role == 'nursing' || role.contains('nurse')) {
      if (clearStack) {
        context.pushNamedAndRemoveUntil(AppRoutes.nursingHomeLayout);
      } else {
        context.pushReplacementNamed(AppRoutes.nursingHomeLayout);
      }
    } else if (role == 'laboratory' || role == 'lab') {
      if (clearStack) {
        context.pushNamedAndRemoveUntil(
          AppRoutes.labHome,
          extra: UserType.laboratory,
        );
      } else {
        context.pushReplacementNamed(
          AppRoutes.labHome,
          extra: UserType.laboratory,
        );
      }
    } else if (role == 'radiology' || role.contains('radio')) {
      if (clearStack) {
        context.pushNamedAndRemoveUntil(
          AppRoutes.labHome,
          extra: UserType.radiologyCenter,
        );
      } else {
        context.pushReplacementNamed(
          AppRoutes.labHome,
          extra: UserType.radiologyCenter,
        );
      }
    } else if (role == 'doctor' || role.contains('doctor')) {
      if (clearStack) {
        context.pushNamedAndRemoveUntil(AppRoutes.homeDoctor);
      } else {
        context.pushReplacementNamed(AppRoutes.homeDoctor);
      }
    } else {
      // Unknown role or patient: clear session, notify, and redirect to login
      FlutterSecureStorageHelper.clearAll();
      UserHiveHelper.clearSession();

      SnackbarHelper.showError(
        context,
        message: context.strings.unsupportedRoleMessage,
      );

      context.pushNamedAndRemoveUntil(AppRoutes.login);
    }
  }

  static String _roleFromUserType(UserType? type) {
    switch (type) {
      case UserType.doctor:
        return 'doctor';
      case UserType.hospital:
        return 'hospital';
      case UserType.laboratory:
        return 'laboratory';
      case UserType.nursingCareProviders:
        return 'nursing';
      case UserType.radiologyCenter:
        return 'radiology';
      default:
        return '';
    }
  }
}
