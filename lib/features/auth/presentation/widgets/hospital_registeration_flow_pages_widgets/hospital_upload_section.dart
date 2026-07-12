import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../document_upload/upload_item_card.dart';

/// The three upload slots for the hospital document upload page:
/// Medical License, Certificates, Tax ID.
class HospitalUploadSection extends StatelessWidget {
  final bool medicalLicensePicked;
  final bool certificatesPicked;
  final bool taxIdPicked;
  final VoidCallback onMedicalLicenseTap;
  final VoidCallback onCertificatesTap;
  final VoidCallback onTaxIdTap;

  const HospitalUploadSection({
    super.key,
    required this.medicalLicensePicked,
    required this.certificatesPicked,
    required this.taxIdPicked,
    required this.onMedicalLicenseTap,
    required this.onCertificatesTap,
    required this.onTaxIdTap,
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
          title: context.strings.taxId,
          subtitle: context.strings.forVerificationPurposes,
          isPicked: taxIdPicked,
          onTap: onTaxIdTap,
        ),
      ],
    );
  }
}
