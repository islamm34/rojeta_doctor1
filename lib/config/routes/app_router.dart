import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/professional_information_page.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/pages/marketing_packages_page.dart';
import 'package:rojeta_doctor/features/financial/presentation/pages/financial_management_page.dart';
import '../../features/doctor/homelayout/presentation/pages/homelayout.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/user_type_selection_page.dart';
import '../../features/auth/presentation/pages/basic_information_page.dart';
import '../../features/auth/presentation/pages/document_upload_page.dart';
import '../../features/auth/presentation/pages/verify_phone_page.dart';
import '../../features/auth/presentation/pages/registration_success_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/doctor/profile/presentation/pages/profile_page.dart';
import '../../features/doctor/profile/presentation/pages/add_clinic_page.dart';
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
  static const String home = '/home';
  static const String profile = '/profile';
  static const String marketingPackages = '/marketing-packages';
  static const String financialManagement = '/financial-management';
  static const String addClinic = '/add-clinic';
  static const String medicalConsultation = '/medical-consultation';
  static const String myPatients = '/my-patients';
  static const String patientDetails = '/patient-details';
  static const String scheduleManagement = '/schedule-management';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.userTypeSelection:
        return MaterialPageRoute(builder: (_) => const UserTypeSelectionPage());
      case AppRoutes.basicInformation:
        return MaterialPageRoute(builder: (_) => const BasicInformationPage());
      case AppRoutes.professionalInformation:
        return MaterialPageRoute(
          builder: (_) => const ProfessionalInformationPage(),
        );
      case AppRoutes.documentUpload:
        return MaterialPageRoute(builder: (_) => const DocumentUploadPage());
      case AppRoutes.verifyPhone:
        final comefrom = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => VerifyPhonePage(comefrom: comefrom),
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
      case AppRoutes.home:
        return RightRouting(const HomeLayoutPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.marketingPackages:
        return MaterialPageRoute(builder: (_) => const MarketingPackagesPage());
      case AppRoutes.financialManagement:
        return MaterialPageRoute(builder: (_) => const FinancialManagementPage());
      case AppRoutes.addClinic:
        return MaterialPageRoute(builder: (_) => const AddClinicPage());
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
        final patientId = settings.arguments as String;
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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
