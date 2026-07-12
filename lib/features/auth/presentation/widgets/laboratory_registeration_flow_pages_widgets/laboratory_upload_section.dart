import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../document_upload/upload_item_card.dart';

class LaboratoryUploadSection extends StatelessWidget {
  final bool medicalLicensePicked;
  final bool certificatesPicked;
  final bool logoPicked;
  final bool nationalIdPicked;
  final bool centerImagesPicked;
  final VoidCallback onMedicalLicenseTap;
  final VoidCallback onCertificatesTap;
  final VoidCallback onLogoTap;
  final VoidCallback onNationalIdTap;
  final VoidCallback onCenterImagesTap;

  const LaboratoryUploadSection({
    super.key,
    required this.medicalLicensePicked,
    required this.certificatesPicked,
    required this.logoPicked,
    required this.nationalIdPicked,
    required this.centerImagesPicked,
    required this.onMedicalLicenseTap,
    required this.onCertificatesTap,
    required this.onLogoTap,
    required this.onNationalIdTap,
    required this.onCenterImagesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UploadItemCard(
          title: context.strings.medicalLicense,
          subtitle: context.strings.uploadClearCopy,
          isPicked: medicalLicensePicked,
          onTap: onMedicalLicenseTap,
        ),
        SizedBox(height: 16.h),
        UploadItemCard(
          title: context.strings.certificates,
          subtitle: context.strings.optionalButRecommended,
          isPicked: certificatesPicked,
          onTap: onCertificatesTap,
        ),
        SizedBox(height: 16.h),
        UploadItemCard(
          title: context.strings.laboratoryLogo,
          subtitle: context.strings.optionalButRecommended,
          isPicked: logoPicked,
          onTap: onLogoTap,
        ),
        SizedBox(height: 16.h),
        UploadItemCard(
          title: context.strings.nationalId,
          subtitle: context.strings.forVerificationPurposes,
          isPicked: nationalIdPicked,
          onTap: onNationalIdTap,
        ),
        SizedBox(height: 16.h),
        UploadItemCard(
          title: context.strings.centerImages,
          subtitle: context.strings.forVerificationPurposes,
          isPicked: centerImagesPicked,
          onTap: onCenterImagesTap,
        ),
      ],
    );
  }
}
