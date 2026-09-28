import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/file_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_event.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_document_card.dart';
import 'widgets/nursing_documents_info_banner.dart';

class NursingDocumentsPage extends StatelessWidget {
  const NursingDocumentsPage({super.key});

  List<NursingDocumentItemModel> _getDefaultDocumentsList(
    BuildContext context,
    List<NursingDocumentItemModel> existingDocs,
  ) {
    final strings = context.strings;
    final defaultDefinitions = [
      (
        type: 'commercial_registration',
        title: strings.officeInformation,
        desc: strings.officeInformationSubtitle,
      ),
      (
        type: 'medical_license',
        title: strings.licenseNumber,
        desc: strings.complianceAndFinancials,
      ),
      (
        type: 'facility_permit',
        title: strings.documents,
        desc: strings.documentsDesc,
      ),
      (
        type: 'tax_card',
        title: strings.complianceAndFinancials,
        desc: strings.financialManagementSubtitle,
      ),
      (
        type: 'national_id',
        title: strings.adminSupport,
        desc: strings.adminSupportDesc,
      ),
    ];

    final result = <NursingDocumentItemModel>[];
    for (final def in defaultDefinitions) {
      final found = existingDocs.where((d) => d.type == def.type).firstOrNull;
      if (found != null) {
        result.add(found);
      } else {
        result.add(
          NursingDocumentItemModel(
            type: def.type,
            title: def.title,
            description: def.desc,
            status: 'pending',
          ),
        );
      }
    }

    // Add any extra uploaded documents not in standard list
    for (final doc in existingDocs) {
      if (!defaultDefinitions.any((d) => d.type == doc.type)) {
        result.add(doc);
      }
    }

    return result;
  }

  Future<void> _pickAndUpload(BuildContext context, String docType) async {
    final file = await FilePickerHelper.pickFile();
    if (file != null && (file.path?.isNotEmpty ?? false) && context.mounted) {
      context.read<NursingBloc>().add(
        UploadNursingDocumentEvent(
          documentType: docType,
          filePath: file.path ?? '',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.strings.uploadedDocuments),
          backgroundColor: const Color(0xFF059669),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.documents,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.status == NursingStatus.loading &&
              state.documents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDocs = _getDefaultDocumentsList(context, state.documents);

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NursingBloc>().add(LoadNursingDocumentsEvent());
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              children: [
                const NursingDocumentsInfoBanner(),
                SizedBox(height: 20.h),
                Text(
                  strings.uploadedDocuments,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 12.h),
                ...allDocs.map(
                  (doc) => NursingDocumentCard(
                    document: doc,
                    onUploadOrReplace: () => _pickAndUpload(context, doc.type),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
