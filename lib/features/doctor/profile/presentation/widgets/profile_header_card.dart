import 'package:path_provider/path_provider.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/core/utils/flutter_secure_storage_helper.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/file_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/image_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../auth/data/models/doctor_specialty.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';

class ProfileHeaderCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeaderCard({super.key, required this.profile});

  Future<void> _pickImage(BuildContext context) async {
    final path = await ImagePickerHelper.pickImagePath(
      source: ImageSource.gallery,
    );
    if (path != null && context.mounted) {
      String persistentPath = path;
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final ext = path.contains('.') ? path.split('.').last : 'jpg';
        final fileName = 'doctor_avatar_${DateTime.now().millisecondsSinceEpoch}.$ext';
        final savedFile = await File(path).copy('${appDir.path}/$fileName');
        persistentPath = savedFile.path;
      } catch (_) {
        persistentPath = path;
      }

      final cachedUser = UserHiveHelper.getUser();
      final userKey = (cachedUser?.id != null)
          ? cachedUser!.id.toString()
          : (cachedUser?.phone ?? profile.id);
      if (cachedUser != null) {
        cachedUser.image = persistentPath;
        UserHiveHelper.saveUser(cachedUser);
      }
      UserHiveHelper.saveUserImage(userKey, persistentPath);
      UserHiveHelper.saveDoctorImage(profile.id, persistentPath);
      try {
        await FlutterSecureStorageHelper.saveDoctorImage(
          profile.id,
          persistentPath,
        );
        await FlutterSecureStorageHelper.saveUserImage(
          userKey,
          persistentPath,
        );
      } catch (_) {}
      if (!context.mounted) return;
      context.read<ProfileBloc>().add(
            UpdateProfileDetailsEvent({
              'imageUrl': persistentPath,
              'image': persistentPath,
              'image_url': persistentPath,
            }),
          );
    }
  }

  Widget _buildAvatar(BuildContext context, ThemeData theme) {
    final imagePath = profile.imageUrl;
    Widget? imageContent;

    if (imagePath != null && imagePath.trim().isNotEmpty) {
      if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
        imageContent = Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, _, _) => _buildPlaceholder(theme),
        );
      } else {
        final file = File(imagePath);
        if (file.existsSync()) {
          imageContent = Image.file(
            file,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => _buildPlaceholder(theme),
          );
        }
      }
    }

    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: imageContent ?? _buildPlaceholder(theme),
            ),
          ),
          Positioned(
            bottom: -4,
            right: -4,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1B6BF3),
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(
                  color: Colors.white,
                  width: 2.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Center(
      child: Icon(
        Icons.person,
        size: 42.sp,
        color: theme.colorScheme.primary.withValues(alpha: 0.6),
      ),
    );
  }

  
  String _generateDoctorQrData(BuildContext context, ProfileModel profile) {
    final buffer = StringBuffer();
    buffer.writeln('د. ${profile.fullName}');
    if (profile.isPro) {
      buffer.writeln('⭐ طبيب موثق ومميز (Pro Doctor)');
    }
    if (profile.specialty != null && profile.specialty!.trim().isNotEmpty) {
      buffer.writeln(
        'التخصص: ${DoctorSpecialty.localizedNameFromValue(context, profile.specialty)}',
      );
    }
    if (profile.subSpecialty != null && profile.subSpecialty!.trim().isNotEmpty) {
      buffer.writeln('التخصص الفرعي: ${profile.subSpecialty}');
    }
    if (profile.phone.trim().isNotEmpty) {
      buffer.writeln('الهاتف: ${profile.phone}');
    }
    if (profile.email.trim().isNotEmpty) {
      buffer.writeln('البريد: ${profile.email}');
    }
    if (profile.yearsOfExperience != null &&
        profile.yearsOfExperience!.trim().isNotEmpty) {
      buffer.writeln('الخبرة: ${profile.yearsOfExperience} سنوات');
    }
    if (profile.education != null && profile.education!.trim().isNotEmpty) {
      buffer.writeln('المؤهل: ${profile.education}');
    }
    if (profile.about != null && profile.about!.trim().isNotEmpty) {
      buffer.writeln('نبذة: ${profile.about}');
    }
    if (profile.clinics.isNotEmpty) {
      buffer.writeln('العيادات:');
      for (final c in profile.clinics) {
        final addr = c.fullAddress ?? ((c.city != null && c.governorate != null) ? "${c.city} - ${c.governorate}" : (c.city ?? c.governorate ?? ""));
        buffer.writeln('- ${c.name}${addr.isNotEmpty ? " ($addr)" : ""}');
      }
    }
    if (profile.services.isNotEmpty) {
      final active = profile.services.where((s) => s.isEnabled).toList();
      if (active.isNotEmpty) {
        buffer.writeln('الخدمات:');
        for (final s in active) {
          buffer.writeln('- ${s.name}: ${s.price} ج.م');
        }
      }
    }
    if (profile.certificates.isNotEmpty) {
      buffer.writeln('الشهادات والمستندات:');
      for (final cert in profile.certificates) {
        final fileName = cert.replaceAll(r'\', '/').split('/').last;
        buffer.writeln('- $fileName');
      }
    }
    buffer.write('روجيتا دكتور | Rojeta Doctor');
    return buffer.toString();
  }

  Widget _buildQrCodeBadge(
    BuildContext context,
    ThemeData theme,
    String qrData,
  ) {
    return GestureDetector(
      onTap: () => _showDoctorQrDialog(context, theme, qrData),
      child: Tooltip(
        message: 'عرض رمز QR',
        child: Container(
          width: 66.w,
          height: 66.w,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 64.w,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildProBadge(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1B6BF3),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B6BF3).withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: const Color(0xFFFBBF24),
            size: 16.sp,
          ),
          SizedBox(width: 5.w),
          Text(
            context.strings.proDoctor,
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeToProButton(BuildContext context, ThemeData theme) {
    return InkWell(
      onTap: () async {
        await context.pushNamed(AppRoutes.marketingPackages);
        if (context.mounted) {
          context.read<ProfileBloc>().add(const LoadProfileEvent());
        }
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 7.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF06B6D4),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF06B6D4).withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15.sp),
            SizedBox(width: 4.w),
            Text(
              context.strings.upgradeToPro,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDoctorQrDialog(
    BuildContext context,
    ThemeData theme,
    String qrData,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profile.fullName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                DoctorSpecialty.localizedNameFromValue(
                  context,
                  profile.specialty,
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 260.w,
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'امسح الرمز لعرض ومشاركة بيانات الطبيب',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('إغلاق'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _addCertificate(BuildContext context, String path) async {
    final bloc = context.read<ProfileBloc>();
    final currentCerts = List<String>.from(
      bloc.state.profile?.certificates ?? profile.certificates,
    );
    if (!currentCerts.contains(path)) {
      currentCerts.add(path);
      final docId = (bloc.state.profile?.id.isNotEmpty == true)
          ? bloc.state.profile!.id
          : (profile.id.isNotEmpty ? profile.id : (UserHiveHelper.getUser()?.id?.toString() ?? ''));
      try {
        await FlutterSecureStorageHelper.saveDoctorCertificates(docId, currentCerts);
        UserHiveHelper.saveDoctorCertificates(docId, currentCerts);
      } catch (_) {}
      bloc.add(
        UpdateProfileDetailsEvent({
          'certificates': currentCerts,
        }),
      );
      final fileName = path.replaceAll(r'\', '/').split('/').last;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت إضافة المستند: $fileName'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _removeCertificate(BuildContext context, String path) async {
    final bloc = context.read<ProfileBloc>();
    final currentCerts = List<String>.from(
      bloc.state.profile?.certificates ?? profile.certificates,
    );
    currentCerts.remove(path);
    final docId = (bloc.state.profile?.id.isNotEmpty == true)
        ? bloc.state.profile!.id
        : (profile.id.isNotEmpty ? profile.id : (UserHiveHelper.getUser()?.id?.toString() ?? ''));
    try {
      await FlutterSecureStorageHelper.saveDoctorCertificates(docId, currentCerts);
      UserHiveHelper.saveDoctorCertificates(docId, currentCerts);
    } catch (_) {}
    bloc.add(
      UpdateProfileDetailsEvent({
        'certificates': currentCerts,
      }),
    );
  }

  Widget _buildUploadOption({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadDocumentsSheet(BuildContext context) {
    final theme = Theme.of(context);
    final profileBloc = context.read<ProfileBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: profileBloc,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (ctx, state) {
              final certs = state.profile?.certificates ?? profile.certificates;

              return Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const Icon(
                            Icons.upload_file,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.strings.uploadDocuments,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'اختر الشهادات والمستندات (ملف أو صورة)',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUploadOption(
                            theme: theme,
                            icon: Icons.photo_library_outlined,
                            title: 'معرض الصور',
                            subtitle: 'JPG, PNG, إلخ',
                            color: Colors.blue,
                            onTap: () async {
                              final path = await ImagePickerHelper.pickImagePath(
                                source: ImageSource.gallery,
                              );
                              if (path != null && ctx.mounted) {
                                _addCertificate(ctx, path);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildUploadOption(
                            theme: theme,
                            icon: Icons.file_present_outlined,
                            title: 'ملف أو مستند',
                            subtitle: 'PDF, Word, إلخ',
                            color: const Color(0xFF8B5CF6),
                            onTap: () async {
                              final file = await FilePickerHelper.pickFile(
                                allowedExtensions: [
                                  'pdf',
                                  'doc',
                                  'docx',
                                  'jpg',
                                  'jpeg',
                                  'png',
                                ],
                              );
                              if (file?.path != null && ctx.mounted) {
                                _addCertificate(ctx, file!.path!);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    if (certs.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      Text(
                        'الشهادات والمستندات المرفوعة (${certs.length}):',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 180.h),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: certs.length,
                          separatorBuilder: (_, _) => SizedBox(height: 8.h),
                          itemBuilder: (c, idx) {
                            final certPath = certs[idx];
                            final fileName = certPath.replaceAll(r'\', '/').split('/').last;
                            final isPdf = fileName.toLowerCase().endsWith('.pdf');
                            final isImage = fileName.toLowerCase().endsWith('.png') ||
                                fileName.toLowerCase().endsWith('.jpg') ||
                                fileName.toLowerCase().endsWith('.jpeg');

                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: theme.colorScheme.outline
                                      .withValues(alpha: 0.15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isPdf
                                        ? Icons.picture_as_pdf
                                        : (isImage
                                            ? Icons.image
                                            : Icons.insert_drive_file),
                                    color: isPdf
                                        ? Colors.red
                                        : (isImage ? Colors.blue : Colors.deepPurple),
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    onPressed: () => _removeCertificate(ctx, certPath),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: 'تم',
                      onPressed: () => Navigator.of(sheetContext).pop(),
                      backgroundColor: const Color(0xFF8B5CF6),
                      borderRadius: 8,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrData = _generateDoctorQrData(context, profile);
    final theme = Theme.of(context);

    final rawName = profile.fullName.trim();
    final displayName = (rawName.startsWith('Dr.') ||
            rawName.startsWith('Dr ') ||
            rawName.startsWith('د.') ||
            rawName.startsWith('د '))
        ? rawName
        : 'Dr. $rawName';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: profile.isPro
                ? Border.all(color: const Color(0xFFF59E0B), width: 2)
                : Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(context, theme),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      DoctorSpecialty.localizedNameFromValue(
                        context,
                        profile.specialty,
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                        fontSize: 14.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      profile.phone,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF94A3B8),
                        fontSize: 13.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              if (profile.isPro) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProBadge(context, theme),
                    SizedBox(height: 10.h),
                    _buildQrCodeBadge(context, theme, qrData),
                  ],
                ),
              ] else ...[
                _buildUpgradeToProButton(context, theme),
              ],
            ],
          ),
        ),
        SizedBox(height: 14.h),
        CustomElevatedButton(
          text: profile.certificates.isNotEmpty
              ? '${context.strings.uploadDocuments} (${profile.certificates.length})'
              : context.strings.uploadDocuments,
          icon: const Icon(Icons.upload_file),
          onPressed: () => _showUploadDocumentsSheet(context),
          backgroundColor: const Color(0xFF8B5CF6),
          borderRadius: 8,
        ),
      ],
    );
  }
}
