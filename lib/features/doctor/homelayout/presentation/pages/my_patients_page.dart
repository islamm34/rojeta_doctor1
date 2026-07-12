import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../bloc/patients/patients_bloc.dart';
import '../bloc/patients/patients_event.dart';
import '../bloc/patients/patients_state.dart';
import '../widgets/my_patients/patient_list_card.dart';
import '../widgets/my_patients/patients_summary_card.dart';

class MyPatientsPage extends StatefulWidget {
  const MyPatientsPage({super.key});

  @override
  State<MyPatientsPage> createState() => _MyPatientsPageState();
}

class _MyPatientsPageState extends State<MyPatientsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PatientsBloc>().add(const FetchPatientsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.strings.myPatients,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocBuilder<PatientsBloc, PatientsState>(
        builder: (context, state) {
          if (state.status == PatientsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PatientsStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error'));
          }

          final patients = state.patients;
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: CustomTextField(
                  controller: _searchController,
                  hintText: context.strings.searchByNameOrPhone,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.w),
                  children: [
                    PatientsSummaryCard(totalPatients: patients.length),
                    SizedBox(height: 16.h),
                    ...patients.map(
                      (patient) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: PatientListCard(patient: patient),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
