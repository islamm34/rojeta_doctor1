// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get chooseTypeTitle => 'Choose User Type';

  @override
  String get chooseTypeSubtitle =>
      'Please select how you want to use the application';

  @override
  String get doctor => 'Doctor';

  @override
  String get doctorDesc =>
      'Register as a practitioner to manage bookings, clinics and consult patients.';

  @override
  String get patient => 'Patient';

  @override
  String get patientDesc =>
      'Register as a patient to seek advice, book appointments and talk to doctors.';

  @override
  String get continueButton => 'Continue';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to access your account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get phone => 'Phone Number';

  @override
  String get fullName => 'Full Name';

  @override
  String get loginButton => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get signUpTitle => 'Create Account';

  @override
  String get signUpSubtitle => 'Fill in details to get started';

  @override
  String get specialization => 'Specialization';

  @override
  String get clinicAddress => 'Clinic Address';

  @override
  String get syndicateNumber => 'Syndicate/License Number';

  @override
  String get bio => 'Bio / Brief Description';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get otpVerificationTitle => 'Verification';

  @override
  String get otpVerificationSubtitle =>
      'Enter the 4-digit code sent to your device';

  @override
  String get verifyButton => 'Verify Code';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidPassword => 'Password must be at least 6 characters';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get welcomeBackUser => 'Welcome, City Lab';

  @override
  String get whatsHappeningToday => 'Here\'s what\'s happening today.';

  @override
  String get todaysBookings => 'TODAY\'S BOOKINGS';

  @override
  String get since8am => '+2 since 8 AM';

  @override
  String get pendingRequests => 'Pending Requests';

  @override
  String get homeVisits => 'Home Visits';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get addTest => 'Add Test';

  @override
  String get manageBranch => 'Manage Branch';

  @override
  String get viewBookings => 'View Bookings';

  @override
  String get upcomingBooking => 'Upcoming Booking';

  @override
  String get viewAll => 'View All';

  @override
  String get save30 => 'Save 30%';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get upgradeDesc => 'Get advanced analytics and unlimited appointments';

  @override
  String get upgradeNow => 'Upgrade Now';
}
