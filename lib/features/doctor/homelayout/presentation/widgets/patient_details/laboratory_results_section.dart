import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/lab_result_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'lab_result_card.dart';

class LaboratoryResultsSection extends StatelessWidget {
  final List<LabResultModel> results;

  const LaboratoryResultsSection({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.laboratoryResults,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: LabResultCard(result: results[index]),
            );
          },
        ),
      ],
    );
  }
}
