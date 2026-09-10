import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/doctor_registration_flow_pages/professional_information_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/hospital_registeration_flow_pages/hospital_professional_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/hospital_registeration_flow_pages/hospital_location_payment_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/hospital_registeration_flow_pages/hospital_document_upload_page.dart';
// Radiology registration flow
import 'package:rojeta_doctor/features/auth/presentation/pages/radiology_registeration_flow_pages/radiology_basic_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/radiology_registeration_flow_pages/radiology_professional_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/radiology_registeration_flow_pages/radiology_home_sample_collection_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/radiology_registeration_flow_pages/radiology_location_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/radiology_registeration_flow_pages/radiology_document_upload_page.dart';
// Laboratory registration flow
import 'package:rojeta_doctor/features/auth/presentation/pages/laboratory_registeration_flow_pages/laboratory_basic_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/laboratory_registeration_flow_pages/laboratory_professional_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/laboratory_registeration_flow_pages/laboratory_home_sample_collection_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/laboratory_registeration_flow_pages/laboratory_location_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/laboratory_registeration_flow_pages/laboratory_document_upload_page.dart';
// Nursing registration flow
import 'package:rojeta_doctor/features/auth/presentation/pages/nursing_care_registerartion_flow_pages/nursing_basic_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/nursing_care_registerartion_flow_pages/nursing_professional_info_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/nursing_care_registerartion_flow_pages/nursing_home_sample_collection_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/nursing_care_registerartion_flow_pages/nursing_location_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/nursing_care_registerartion_flow_pages/nursing_document_upload_page.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/pages/marketing_packages_page.dart';
import 'package:rojeta_doctor/features/financial/presentation/pages/financial_management_page.dart';
import '../../features/doctor/chat/presentation/pages/doctor_conversations_page.dart';
import '../../features/doctor/chat/presentation/pages/doctor_chat_messages_page.dart';
import '../../features/doctor/chat/data/models/doctor_chat_models.dart';
import '../../features/doctor/homelayout/presentation/pages/homelayout.dart';
import '../../features/hospital/homelayout/presentation/pages/hospital_homelayout_page.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/user_type_selection_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/basic_information_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/document_upload_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/verify_phone_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/registration_success_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/login_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/doctor_registration_flow_pages/reset_password_page.dart';
import '../../features/doctor/profile/presentation/pages/profile_page.dart';
import '../../features/doctor/profile/presentation/pages/add_clinic_page.dart';
import '../../features/doctor/profile/presentation/bloc/profile/profile_bloc.dart';
import '../../features/doctor/profile/data/models/clinic_model.dart';
import '../../features/doctor/homelayout/presentation/pages/medical_consultation_page.dart';
import '../../features/doctor/homelayout/data/models/doctor_appointment_model.dart';
import '../../features/doctor/homelayout/presentation/pages/my_patients_page.dart';
import '../../features/doctor/homelayout/presentation/pages/patient_details_page.dart';
import '../../features/doctor/homelayout/presentation/bloc/patients/patients_bloc.dart';
import '../../features/doctor/homelayout/presentation/bloc/medical_consultation/medical_consultation_bloc.dart';
import '../../features/doctor/homelayout/presentation/pages/schedule_management_page.dart';
import '../../features/doctor/homelayout/presentation/bloc/schedule/schedule_bloc.dart';
import '../../features/doctor/homelayout/presentation/bloc/schedule/schedule_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injector.dart';
import '../../features/hospital/settings/presentation/pages/settings_page.dart';
import '../../features/lab&radiology/homelayout/presentation/pages/lab_home_layout_page.dart';
import '../../features/lab&radiology/homelayout/presentation/pages/add_service/add_lab_service_page.dart';
import '../../features/booking/presentation/pages/booking_management_page.dart';
import '../../features/lab&radiology/homelayout/presentation/pages/manage_branch/manage_branch_page.dart';
import '../../features/lab&radiology/homelayout/presentation/pages/manage_branch/add_branch_page.dart';
import '../../features/lab&radiology/homelayout/presentation/pages/home_visits/home_visits_page.dart';
import '../../features/lab&radiology/settings/presentation/pages/general_settings_page.dart';
import '../../features/lab&radiology/settings/presentation/pages/lab_info_page.dart';
import '../../features/lab&radiology/settings/presentation/pages/working_hours_page.dart';
import '../../features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import '../../features/nursing/homelayout/presentation/pages/nursing_home_layout.dart';
import '../../features/nursing/homelayout/presentation/pages/nursing_add_service_page.dart';
import '../../features/nursing/homelayout/presentation/pages/nursing_add_staff_page.dart';
import '../../features/nursing/homelayout/presentation/pages/profile/nursing_settings_page.dart';
import '../../features/nursing/homelayout/presentation/pages/profile/nursing_office_info_page.dart';
import '../../features/nursing/homelayout/presentation/pages/profile/nursing_working_hours_page.dart';
import '../../features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import '../../features/auth/data/models/user_type_model.dart';
import 'custom_routes.dart';

class AppRoutes {
  static const String splash = '/';
  static const String userTypeSelection = '/user-type-selection';
  static const String basicInformation = '/basic-information';
  static const String professionalInformation = '/professional-information';
  static const String documentUpload = '/documentUpload';
  static const String verifyPhone = '/verifyPhone';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String registrationSuccess = '/registration-success';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String homeDoctor = '/home';
  static const String profile = '/profile';
  static const String marketingPackages = '/marketing-packages';
  static const String financialManagement = '/financial-management';
  static const String addClinic = '/add-clinic';
  static const String medicalConsultation = '/medical-consultation';
  static const String myPatients = '/my-patients';
  static const String patientDetails = '/patient-details';
  static const String scheduleManagement = '/schedule-management';
  static const String hospitalHome = '/hospital-home-layout';
  static const String addSpecialty = '/add-specialty';
  static const String addDoctor = '/add-doctor';
  static const String laboratoryManagement = '/laboratory-management';
  static const String radiologyManagement = '/radiology-management';
  static const String icuManagement = '/icu-management';
  static const String incubatorManagement = '/incubator-management';
  // Hospital registration flow
  static const String hospitalProfessionalInfo = '/hospital-professional-info';
  static const String hospitalLocationPayment = '/hospital-location-payment';
  static const String hospitalDocumentUpload = '/hospital-document-upload';
  // Radiology registration flow
  static const String radiologyBasicInfo = '/radiology-basic-info';
  static const String radiologyProfessionalInfo =
      '/radiology-professional-info';
  static const String radiologyHomeSampleCollection =
      '/radiology-home-sample-collection';
  static const String radiologyLocation = '/radiology-location';
  static const String radiologyDocumentUpload = '/radiology-document-upload';
  // Laboratory registration flow
  static const String laboratoryBasicInfo = '/laboratory-basic-info';
  static const String laboratoryProfessionalInfo =
      '/laboratory-professional-info';
  static const String laboratoryHomeSampleCollection =
      '/laboratory-home-sample-collection';
  static const String laboratoryLocation = '/laboratory-location';
  static const String laboratoryDocumentUpload = '/laboratory-document-upload';
  // Nursing registration flow
  static const String nursingBasicInfo = '/nursing-basic-info';
  static const String nursingProfessionalInfo = '/nursing-professional-info';
  static const String nursingHomeSampleCollection =
      '/nursing-home-sample-collection';
  static const String nursingSettings = '/nursing-settings';
  static const String nursingOfficeInfo = '/nursing-office-info';
  static const String nursingWorkingHours = '/nursing-working-hours';
  static const String nursingLocation = '/nursing-location';
  static const String nursingDocumentUpload = '/nursing-document-upload';
  static const String settings = '/settings';
  static const String labHome = '/lab-home';
  static const String addLabService = '/add-lab-service';
  static const String bookingManagement = '/booking-management';
  static const String manageBranch = '/manage-branch';
  static const String addBranch = '/add-branch';
  static const String homeVisits = '/home-visits';
  static const String generalSettings = '/general-settings';
  static const String labInfo = '/lab-info';
  static const String workingHours = '/working-hours';
  static const String nursingHomeLayout = '/nursing-home-layout';
  static const String nursingAddService = '/nursing-add-service';
  static const String nursingAddNurse = '/nursing-add-nurse';
  static const String doctorConversations = '/doctor-conversations';
  static const String doctorChatMessages = '/doctor-chat-messages';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.userTypeSelection:
        return MaterialPageRoute(builder: (_) => const UserTypeSelectionPage());
      case AppRoutes.basicInformation:
        final args = settings.arguments;
        final isFinalStep = args is bool
            ? args
            : (args is Map<String, dynamic>
                  ? (args['isFinalStep'] as bool? ?? false)
                  : false);
        return MaterialPageRoute(
          builder: (_) => BasicInformationPage(isFinalStep: isFinalStep),
        );
      case AppRoutes.professionalInformation:
        return MaterialPageRoute(
          builder: (_) => const ProfessionalInformationPage(),
        );
      case AppRoutes.documentUpload:
        return MaterialPageRoute(builder: (_) => const DocumentUploadPage());
      case AppRoutes.verifyPhone:
        String? comefrom;
        String? phone;
        if (settings.arguments is String) {
          comefrom = settings.arguments as String;
        } else if (settings.arguments is Map) {
          final args = settings.arguments as Map;
          comefrom = args['comefrom'] as String?;
          phone = args['phone'] as String?;
        }
        return MaterialPageRoute(
          builder: (_) => VerifyPhonePage(comefrom: comefrom, phone: phone),
        );
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
      case AppRoutes.registrationSuccess:
        return MaterialPageRoute(
          builder: (_) => const RegistrationSuccessPage(),
        );
      case AppRoutes.homeDoctor:
        return RightRouting(const HomeLayoutPage());
      case AppRoutes.hospitalHome:
        return RightRouting(const HospitalHomeLayoutPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.marketingPackages:
        return MaterialPageRoute(builder: (_) => const MarketingPackagesPage());
      case AppRoutes.financialManagement:
        return MaterialPageRoute(
          builder: (_) => const FinancialManagementPage(),
        );
      case AppRoutes.addClinic:
        final clinic = settings.arguments as ClinicModel?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => injector<ProfileBloc>(),
            child: AddClinicPage(clinic: clinic),
          ),
        );
      case AppRoutes.medicalConsultation:
        final appointment = settings.arguments as DoctorAppointmentModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => injector<MedicalConsultationBloc>(),
            child: MedicalConsultationPage(appointment: appointment),
          ),
        );
      case AppRoutes.myPatients:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => injector<PatientsBloc>(),
            child: const MyPatientsPage(),
          ),
        );
      case AppRoutes.patientDetails:
        final patientId = settings.arguments is String
            ? settings.arguments as String
            : (settings.arguments?.toString() ?? '');
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => injector<PatientsBloc>(),
            child: PatientDetailsPage(patientId: patientId),
          ),
        );
      case AppRoutes.scheduleManagement:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => injector<ScheduleBloc>()..add(FetchScheduleEvent()),
            child: const ScheduleManagementPage(),
          ),
        );
      case AppRoutes.doctorConversations:
        return MaterialPageRoute(
          builder: (_) => const DoctorConversationsPage(),
        );
      case AppRoutes.doctorChatMessages:
        final conversation = settings.arguments as DoctorConversationModel;
        return MaterialPageRoute(
          builder: (_) => DoctorChatMessagesPage(conversation: conversation),
        );
      // Hospital registration flow
      case AppRoutes.hospitalProfessionalInfo:
        return MaterialPageRoute(
          builder: (_) => const HospitalProfessionalInfoPage(),
        );
      case AppRoutes.hospitalLocationPayment:
        return MaterialPageRoute(
          builder: (_) => const HospitalLocationPaymentPage(),
        );
      case AppRoutes.hospitalDocumentUpload:
        return MaterialPageRoute(
          builder: (_) => const HospitalDocumentUploadPage(),
        );
      // Radiology registration flow
      case AppRoutes.radiologyBasicInfo:
        return MaterialPageRoute(
          builder: (_) => const RadiologyBasicInfoPage(),
        );
      case AppRoutes.radiologyProfessionalInfo:
        return MaterialPageRoute(
          builder: (_) => const RadiologyProfessionalInfoPage(),
        );
      case AppRoutes.radiologyHomeSampleCollection:
        return MaterialPageRoute(
          builder: (_) => const RadiologyHomeSampleCollectionPage(),
        );
      case AppRoutes.radiologyLocation:
        return MaterialPageRoute(builder: (_) => const RadiologyLocationPage());
      case AppRoutes.radiologyDocumentUpload:
        return MaterialPageRoute(
          builder: (_) => const RadiologyDocumentUploadPage(),
        );
      // Laboratory registration flow
      case AppRoutes.laboratoryBasicInfo:
        return MaterialPageRoute(
          builder: (_) => const LaboratoryBasicInfoPage(),
        );
      case AppRoutes.laboratoryProfessionalInfo:
        return MaterialPageRoute(
          builder: (_) => const LaboratoryProfessionalInfoPage(),
        );
      case AppRoutes.laboratoryHomeSampleCollection:
        return MaterialPageRoute(
          builder: (_) => const LaboratoryHomeSampleCollectionPage(),
        );
      case AppRoutes.laboratoryLocation:
        return MaterialPageRoute(
          builder: (_) => const LaboratoryLocationPage(),
        );
      case AppRoutes.laboratoryDocumentUpload:
        return MaterialPageRoute(
          builder: (_) => const LaboratoryDocumentUploadPage(),
        );
      // Nursing registration flow
      case AppRoutes.nursingBasicInfo:
        return MaterialPageRoute(builder: (_) => const NursingBasicInfoPage());
      case AppRoutes.nursingProfessionalInfo:
        return MaterialPageRoute(
          builder: (_) => const NursingProfessionalInfoPage(),
        );
      case AppRoutes.nursingHomeSampleCollection:
        return MaterialPageRoute(
          builder: (_) => const NursingHomeSampleCollectionPage(),
        );
      case AppRoutes.nursingLocation:
        return MaterialPageRoute(builder: (_) => const NursingLocationPage());
      case AppRoutes.nursingDocumentUpload:
        return MaterialPageRoute(
          builder: (_) => const NursingDocumentUploadPage(),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.labHome:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => LabHomeLayoutPage(userType: userType),
        );
      case AppRoutes.addLabService:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => AddLabServicePage(userType: userType),
        );
      case AppRoutes.bookingManagement:
        return MaterialPageRoute(
          builder: (_) =>
              BookingManagementPage(userType: UserType.radiologyCenter),
        );
      case AppRoutes.manageBranch:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => ManageBranchPage(userType: userType),
        );
      case AppRoutes.addBranch:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => AddBranchPage(userType: userType),
        );
      case AppRoutes.homeVisits:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => HomeVisitsPage(userType: userType),
        );
      case AppRoutes.generalSettings:
        final userType =
            settings.arguments as UserType? ?? UserType.radiologyCenter;
        return MaterialPageRoute(
          builder: (_) => GeneralSettingsPage(userType: userType),
        );
      case AppRoutes.labInfo:
        final isRadiology = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: injector<SettingsBloc>(),
            child: LabInfoPage(isRadiology: isRadiology),
          ),
        );
      case AppRoutes.workingHours:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: injector<SettingsBloc>(),
            child: const WorkingHoursPage(),
          ),
        );
      case AppRoutes.nursingHomeLayout:
        return MaterialPageRoute(builder: (_) => const NursingHomeLayout());
      case AppRoutes.nursingAddService:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as NursingBloc,
            child: const NursingAddServicePage(),
          ),
        );
      case AppRoutes.nursingAddNurse:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as NursingBloc,
            child: const NursingAddStaffPage(),
          ),
        );
      case AppRoutes.nursingSettings:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as NursingBloc,
            child: const NursingSettingsPage(),
          ),
        );
      case AppRoutes.nursingOfficeInfo:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as NursingBloc,
            child: const NursingOfficeInfoPage(),
          ),
        );
      case AppRoutes.nursingWorkingHours:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as NursingBloc,
            child: const NursingWorkingHoursPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
