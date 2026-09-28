import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';
import 'nursing_document_status_badge.dart';

class NursingDocumentCard extends StatelessWidget {
  final NursingDocumentItemModel document;
  final VoidCallback onUploadOrReplace;

  const NursingDocumentCard({
    super.key,
    required this.document,
    required this.onUploadOrReplace,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final hasFile = document.fileUrl.isNotEmpty || document.fileName.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: const Color(0xFF0F2D52),
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.title.isNotEmpty ? document.title : strings.documents,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    if (document.description.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        document.description,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              NursingDocumentStatusBadge(status: document.status),
            ],
          ),
          if (hasFile) ...[
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file,
                    size: 16.w,
                    color: const Color(0xFF64748B),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      document.fileName.isNotEmpty
                          ? document.fileName
                          : (document.fileUrl.split('/').last.isNotEmpty
                              ? document.fileUrl.split('/').last
                              : strings.uploadedDocuments),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF334155),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (document.uploadedAt.isNotEmpty)
                    Text(
                      document.uploadedAt.split('T').first,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (document.rejectionReason.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFDC2626),
                    size: 16.w,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      document.rejectionReason,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF991B1B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onUploadOrReplace,
              icon: Icon(
                hasFile ? Icons.refresh : Icons.cloud_upload_outlined,
                size: 16.w,
                color: const Color(0xFF2563EB),
              ),
              label: Text(
                hasFile ? strings.uploadDocuments : strings.documentUpload,
                style: TextStyle(
                  color: const Color(0xFF2563EB),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2563EB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
