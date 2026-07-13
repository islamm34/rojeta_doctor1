import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../data/models/hospital_service_model.dart';

class HospitalServiceToggle extends StatelessWidget {
  final HospitalServiceModel service;
  final ValueChanged<bool> onChanged;

  const HospitalServiceToggle({
    super.key,
    required this.service,
    required this.onChanged,
  });

  String _getLocalizedTitle(BuildContext context, String key) {
    switch (key) {
      case 'serviceLaboratory':
        return context.strings.serviceLaboratory;
      case 'serviceClinics':
        return context.strings.serviceClinics;
      case 'serviceRadiology':
        return context.strings.serviceRadiology;
      case 'serviceAmbulance':
        return context.strings.serviceAmbulance;
      case 'serviceICU':
        return context.strings.serviceICU;
      case 'serviceIncubators':
        return context.strings.serviceIncubators;
      case 'serviceHomeCare':
        return context.strings.serviceHomeCare;
      default:
        return key;
    }
  }

  String _getLocalizedDesc(BuildContext context, String key) {
    switch (key) {
      case 'serviceLaboratoryDesc':
        return context.strings.serviceLaboratoryDesc;
      case 'serviceClinicsDesc':
        return context.strings.serviceClinicsDesc;
      case 'serviceRadiologyDesc':
        return context.strings.serviceRadiologyDesc;
      case 'serviceAmbulanceDesc':
        return context.strings.serviceAmbulanceDesc;
      case 'serviceICUDesc':
        return context.strings.serviceICUDesc;
      case 'serviceIncubatorsDesc':
        return context.strings.serviceIncubatorsDesc;
      case 'serviceHomeCareDesc':
        return context.strings.serviceHomeCareDesc;
      default:
        return key;
    }
  }

  String _getLocalizedExtraInfo(BuildContext context, String key) {
    if (key == 'totalIcuBeds') return context.strings.totalIcuBeds;
    return key;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.homeBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.local_hospital, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLocalizedTitle(context, service.titleKey),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getLocalizedDesc(context, service.descriptionKey),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (service.extraInfoKey != null &&
                    service.extraInfoValue != null) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.homeBg,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '${_getLocalizedExtraInfo(context, service.extraInfoKey!)} ${service.extraInfoValue}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: service.isEnabled,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
