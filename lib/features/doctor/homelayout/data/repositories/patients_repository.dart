import '../models/lab_result_model.dart';
import '../models/patient_details_model.dart';
import '../models/patient_model.dart';
import '../models/visit_model.dart';

class PatientsRepository {
  Future<List<PatientModel>> getPatients() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network latency
    return [
      PatientModel(
        id: '1',
        name: 'Mohamed Ali',
        phone: '01012345678',
        age: 35,
        gender: 'Male',
        visitsCount: 5,
        lastVisitDate: DateTime(2026, 2, 5),
        lastDiagnosis: 'Hypertension - under control',
      ),
      PatientModel(
        id: '2',
        name: 'Sara Ahmed',
        phone: '01123456789',
        age: 28,
        gender: 'Female',
        visitsCount: 3,
        lastVisitDate: DateTime(2026, 2, 4),
        lastDiagnosis: 'Routine check-up - healthy',
      ),
      PatientModel(
        id: '3',
        name: 'Ahmed Hassan',
        phone: '01234567890',
        age: 45,
        gender: 'Male',
        visitsCount: 8,
        lastVisitDate: DateTime(2026, 2, 3),
        lastDiagnosis: 'Cardiac arrhythmia - medication adjusted',
      ),
      PatientModel(
        id: '4',
        name: 'Fatma Mahmoud',
        phone: '01098765432',
        age: 52,
        gender: 'Female',
        visitsCount: 12,
        lastVisitDate: DateTime(2026, 2, 2),
        lastDiagnosis: 'Coronary artery disease - stable',
      ),
      PatientModel(
        id: '5',
        name: 'Heba Salem',
        phone: '01187654321',
        age: 30,
        gender: 'Female',
        visitsCount: 2,
        lastVisitDate: DateTime(2026, 2, 1),
        lastDiagnosis: 'Chest pain - non-cardiac origin',
      ),
    ];
  }

  Future<PatientDetailsModel> getPatientDetails(String id) async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network latency
    return PatientDetailsModel(
      basicInfo: PatientModel(
        id: '1',
        name: 'Mohamed Ali',
        phone: '01012345678',
        age: 35,
        gender: 'Male',
        visitsCount: 5,
        lastVisitDate: DateTime(2026, 2, 5),
        lastDiagnosis: 'Hypertension - under control',
      ),
      allergies: const ['Penicillin', 'Peanuts'],
      chronicConditions: const ['Hypertension'],
      visitHistory: [
        VisitModel(
          id: 'v1',
          date: DateTime(2026, 2, 5),
          type: 'Clinic Visit',
          diagnosis: 'Hypertension - under control',
          prescription:
              'Amlodipine 5mg once daily, Continue current medication',
          notes:
              'Blood pressure: 130/85 mmHg. Patient reports good compliance with medication.',
          followUpDate: DateTime(2026, 3, 5),
        ),
        VisitModel(
          id: 'v2',
          date: DateTime(2026, 1, 15),
          type: 'Follow-up',
          diagnosis: 'Hypertension monitoring',
          prescription: 'Amlodipine 5mg once daily',
          notes:
              'Blood pressure: 135/88 mmHg. Advised lifestyle modifications.',
          followUpDate: DateTime(2026, 2, 15),
        ),
        VisitModel(
          id: 'v3',
          date: DateTime(2025, 12, 10),
          type: 'Clinic Visit',
          diagnosis: 'Chest pain evaluation - Non-cardiac',
          prescription: 'Omeprazole 20mg twice daily',
          notes: 'ECG normal. Chest pain likely due to gastric reflux.',
          followUpDate: DateTime(2026, 1, 10),
        ),
      ],
      labResults: [
        LabResultModel(
          id: 'l1',
          date: DateTime(2026, 2, 5),
          testsPerformed: 'CBC, Lipid Profile, HbA1c',
          results: 'All within normal limits',
          notes: 'HbA1c: 5.6%, Cholesterol: 180 mg/dL',
          isNormal: true,
        ),
        LabResultModel(
          id: 'l2',
          date: DateTime(2025, 12, 10),
          testsPerformed: 'ECG, Troponin',
          results: 'Normal',
          notes: 'No cardiac markers elevated',
          isNormal: true,
        ),
      ],
    );
  }
}
