import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @chooseTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose User Type'**
  String get chooseTypeTitle;

  /// No description provided for @chooseTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select how you want to use the application'**
  String get chooseTypeSubtitle;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @doctorDesc.
  ///
  /// In en, this message translates to:
  /// **'Register as a practitioner to manage bookings, clinics and consult patients.'**
  String get doctorDesc;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @patientDesc.
  ///
  /// In en, this message translates to:
  /// **'Register as a patient to seek advice, book appointments and talk to doctors.'**
  String get patientDesc;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your account'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in details to get started'**
  String get signUpSubtitle;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @clinicAddress.
  ///
  /// In en, this message translates to:
  /// **'Clinic Address'**
  String get clinicAddress;

  /// No description provided for @syndicateNumber.
  ///
  /// In en, this message translates to:
  /// **'Syndicate/License Number'**
  String get syndicateNumber;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio / Brief Description'**
  String get bio;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get otpVerificationTitle;

  /// No description provided for @otpVerificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4-digit code sent to your device'**
  String get otpVerificationSubtitle;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyButton;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get invalidPassword;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @welcomeBackUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, City Lab'**
  String get welcomeBackUser;

  /// No description provided for @whatsHappeningToday.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what\'s happening today.'**
  String get whatsHappeningToday;

  /// No description provided for @todaysBookings.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S BOOKINGS'**
  String get todaysBookings;

  /// No description provided for @since8am.
  ///
  /// In en, this message translates to:
  /// **'+2 since 8 AM'**
  String get since8am;

  /// No description provided for @pendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get pendingRequests;

  /// No description provided for @homeVisits.
  ///
  /// In en, this message translates to:
  /// **'Home Visits'**
  String get homeVisits;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @addTest.
  ///
  /// In en, this message translates to:
  /// **'Add Test'**
  String get addTest;

  /// No description provided for @manageBranch.
  ///
  /// In en, this message translates to:
  /// **'Manage Branch'**
  String get manageBranch;

  /// No description provided for @viewBookings.
  ///
  /// In en, this message translates to:
  /// **'View Bookings'**
  String get viewBookings;

  /// No description provided for @upcomingBooking.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Booking'**
  String get upcomingBooking;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @save30.
  ///
  /// In en, this message translates to:
  /// **'Save 30%'**
  String get save30;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @upgradeDesc.
  ///
  /// In en, this message translates to:
  /// **'Get advanced analytics and unlimited appointments'**
  String get upgradeDesc;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @step1Of5.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 5'**
  String get step1Of5;

  /// No description provided for @joinRujeta.
  ///
  /// In en, this message translates to:
  /// **'Join Rujeta'**
  String get joinRujeta;

  /// No description provided for @startProvidingQualityHealthcareServices.
  ///
  /// In en, this message translates to:
  /// **'Start providing quality healthcare services'**
  String get startProvidingQualityHealthcareServices;

  /// No description provided for @selectYourAccountType.
  ///
  /// In en, this message translates to:
  /// **'Select Your Account Type'**
  String get selectYourAccountType;

  /// No description provided for @hospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospital;

  /// No description provided for @radiologyCenter.
  ///
  /// In en, this message translates to:
  /// **'Radiology Center'**
  String get radiologyCenter;

  /// No description provided for @laboratory.
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get laboratory;

  /// No description provided for @nursingCareProviders.
  ///
  /// In en, this message translates to:
  /// **'Nursing Care Providers'**
  String get nursingCareProviders;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login here'**
  String get loginHere;

  /// No description provided for @step2Of5.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 5'**
  String get step2Of5;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Dr. Ahmed Hassan'**
  String get fullNameHint;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'ahmed@example.com'**
  String get emailHint;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @mobileHint.
  ///
  /// In en, this message translates to:
  /// **'01xxxxxxxxx'**
  String get mobileHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @step3Of5.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 5'**
  String get step3Of5;

  /// No description provided for @professionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get professionalInformation;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty *'**
  String get specialty;

  /// No description provided for @subSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Sub-Specialty'**
  String get subSpecialty;

  /// No description provided for @subSpecialtyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Interventional Cardiology'**
  String get subSpecialtyHint;

  /// No description provided for @medicalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Medical License Number'**
  String get medicalLicenseNumber;

  /// No description provided for @medicalLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'مثال'**
  String get medicalLicenseHint;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience *'**
  String get yearsOfExperience;

  /// No description provided for @yearsOfExperienceHint.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get yearsOfExperienceHint;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @educationAndCertifications.
  ///
  /// In en, this message translates to:
  /// **'Education & Certifications'**
  String get educationAndCertifications;

  /// No description provided for @educationHint.
  ///
  /// In en, this message translates to:
  /// **'Medical degree, fellowships, certifications...'**
  String get educationHint;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutHint.
  ///
  /// In en, this message translates to:
  /// **'Brief description about yourself and your practice...'**
  String get aboutHint;

  /// No description provided for @step4Of5.
  ///
  /// In en, this message translates to:
  /// **'Step 4 of 5'**
  String get step4Of5;

  /// No description provided for @documentUpload.
  ///
  /// In en, this message translates to:
  /// **'Document Upload'**
  String get documentUpload;

  /// No description provided for @documentUploadDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload the front and the back side for all documents'**
  String get documentUploadDesc;

  /// No description provided for @medicalLicense.
  ///
  /// In en, this message translates to:
  /// **'Medical License'**
  String get medicalLicense;

  /// No description provided for @uploadClearCopy.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear copy'**
  String get uploadClearCopy;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @optionalButRecommended.
  ///
  /// In en, this message translates to:
  /// **'Optional but recommended'**
  String get optionalButRecommended;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @forVerificationPurposes.
  ///
  /// In en, this message translates to:
  /// **'For verification purposes'**
  String get forVerificationPurposes;

  /// No description provided for @termsAndConditionsAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get termsAndConditionsAgree;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsNotice.
  ///
  /// In en, this message translates to:
  /// **'. I understand that my account will be reviewed and must be approved before I can start accepting appointments.'**
  String get termsNotice;

  /// No description provided for @whatHappensNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next?'**
  String get whatHappensNext;

  /// No description provided for @nextStep1.
  ///
  /// In en, this message translates to:
  /// **'You will receive an OTP to verify your phone number'**
  String get nextStep1;

  /// No description provided for @nextStep2.
  ///
  /// In en, this message translates to:
  /// **'Our team will review your application within 1-3 business days'**
  String get nextStep2;

  /// No description provided for @nextStep3.
  ///
  /// In en, this message translates to:
  /// **'Once approved, you can start accepting appointments'**
  String get nextStep3;

  /// No description provided for @completeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get completeRegistration;

  /// No description provided for @whatHappensNextDesc.
  ///
  /// In en, this message translates to:
  /// **'Once you submit your documents, our team will review them within 24-48 hours. You will receive an email and notification once your account is verified.'**
  String get whatHappensNextDesc;

  /// No description provided for @step5Of5.
  ///
  /// In en, this message translates to:
  /// **'Step 5 of 5'**
  String get step5Of5;

  /// No description provided for @verifyYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Phone'**
  String get verifyYourPhone;

  /// No description provided for @weSentVerificationCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to'**
  String get weSentVerificationCodeTo;

  /// No description provided for @enterOtpCode.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP Code'**
  String get enterOtpCode;

  /// No description provided for @verifyAndCompleteRegistration.
  ///
  /// In en, this message translates to:
  /// **'Verify & Complete Registration'**
  String get verifyAndCompleteRegistration;

  /// No description provided for @yourRequestIsUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Your request is now under review'**
  String get yourRequestIsUnderReview;

  /// No description provided for @requestSummary.
  ///
  /// In en, this message translates to:
  /// **'Request Summary'**
  String get requestSummary;

  /// No description provided for @submittedDataForReview.
  ///
  /// In en, this message translates to:
  /// **'Submitted data for review'**
  String get submittedDataForReview;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name'**
  String get doctorName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @uploadedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Documents'**
  String get uploadedDocuments;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get example;

  /// No description provided for @whatsNext.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get whatsNext;

  /// No description provided for @whatsNextStep1.
  ///
  /// In en, this message translates to:
  /// **'Our team will review your application and attached documents'**
  String get whatsNextStep1;

  /// No description provided for @whatsNextStep2.
  ///
  /// In en, this message translates to:
  /// **'The review process may take 24 to 48 business hours'**
  String get whatsNextStep2;

  /// No description provided for @whatsNextStep3.
  ///
  /// In en, this message translates to:
  /// **'You will receive a text message and notification upon approval of your request'**
  String get whatsNextStep3;

  /// No description provided for @whatsNextStep4.
  ///
  /// In en, this message translates to:
  /// **'After approval, you can log in and start receiving requests'**
  String get whatsNextStep4;

  /// No description provided for @requestNumber.
  ///
  /// In en, this message translates to:
  /// **'Request Number'**
  String get requestNumber;

  /// No description provided for @keepThisNumberForTracking.
  ///
  /// In en, this message translates to:
  /// **'Keep this number for tracking'**
  String get keepThisNumberForTracking;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @customerService.
  ///
  /// In en, this message translates to:
  /// **'Customer Service:'**
  String get customerService;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get emailLabel;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @workingHoursDesc.
  ///
  /// In en, this message translates to:
  /// **'Saturday - Thursday (9 AM - 6 PM)'**
  String get workingHoursDesc;

  /// No description provided for @returnToLoginPage.
  ///
  /// In en, this message translates to:
  /// **'Return to login page'**
  String get returnToLoginPage;

  /// No description provided for @thankYouForJoining.
  ///
  /// In en, this message translates to:
  /// **'Thank you for choosing to join us'**
  String get thankYouForJoining;

  /// No description provided for @lookForwardToWorkingWithYou.
  ///
  /// In en, this message translates to:
  /// **'We look forward to working with you soon!'**
  String get lookForwardToWorkingWithYou;

  /// No description provided for @signInToContinueToRujeta.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to Rujeta'**
  String get signInToContinueToRujeta;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @enterYourPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPasswordHint;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'01234567890'**
  String get phoneHint;

  /// No description provided for @byContinuingAgreeTermsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms & Privacy Policy'**
  String get byContinuingAgreeTermsPrivacy;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to reset password'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get sendResetCode;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new strong password for your account'**
  String get resetPasswordSubtitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @emailNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications via email'**
  String get emailNotificationsDesc;

  /// No description provided for @smsNotifications.
  ///
  /// In en, this message translates to:
  /// **'SMS Notifications'**
  String get smsNotifications;

  /// No description provided for @smsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive SMS for important updates'**
  String get smsNotificationsDesc;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive push notifications on your device'**
  String get pushNotificationsDesc;

  /// No description provided for @appointmentReminders.
  ///
  /// In en, this message translates to:
  /// **'Appointment Reminders'**
  String get appointmentReminders;

  /// No description provided for @appointmentRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily summary of scheduled visits'**
  String get appointmentRemindersDesc;

  /// No description provided for @marketingEmails.
  ///
  /// In en, this message translates to:
  /// **'Marketing Emails'**
  String get marketingEmails;

  /// No description provided for @marketingEmailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive promotional and marketing emails'**
  String get marketingEmailsDesc;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @twoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuth;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @marketingAndPromotion.
  ///
  /// In en, this message translates to:
  /// **'Marketing & Promotion'**
  String get marketingAndPromotion;

  /// No description provided for @marketingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Grow your practice online'**
  String get marketingSubtitle;

  /// No description provided for @marketingDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 500K+ potential patients through our social media channels. Professional content creation and targeted marketing to grow your practice.'**
  String get marketingDesc;

  /// No description provided for @marketingPoint1.
  ///
  /// In en, this message translates to:
  /// **'Facebook, Instagram, Twitter & YouTube'**
  String get marketingPoint1;

  /// No description provided for @marketingPoint2.
  ///
  /// In en, this message translates to:
  /// **'Professional content & design'**
  String get marketingPoint2;

  /// No description provided for @marketingPoint3.
  ///
  /// In en, this message translates to:
  /// **'Performance analytics & insights'**
  String get marketingPoint3;

  /// No description provided for @viewMarketingPackages.
  ///
  /// In en, this message translates to:
  /// **'View Marketing Packages'**
  String get viewMarketingPackages;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @monthlyStatistics.
  ///
  /// In en, this message translates to:
  /// **'Monthly Statistics'**
  String get monthlyStatistics;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @aboutRujeta.
  ///
  /// In en, this message translates to:
  /// **'About Rujeta'**
  String get aboutRujeta;

  /// No description provided for @rujetaDoctorApp.
  ///
  /// In en, this message translates to:
  /// **'Rujeta Doctor App'**
  String get rujetaDoctorApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @todaysIncome.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Income'**
  String get todaysIncome;

  /// No description provided for @todaysAppointments.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Appointments'**
  String get todaysAppointments;

  /// No description provided for @newRequests.
  ///
  /// In en, this message translates to:
  /// **'New Requests'**
  String get newRequests;

  /// No description provided for @manageBookings.
  ///
  /// In en, this message translates to:
  /// **'Manage bookings'**
  String get manageBookings;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @setAvailability.
  ///
  /// In en, this message translates to:
  /// **'Set availability'**
  String get setAvailability;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @viewRecords.
  ///
  /// In en, this message translates to:
  /// **'View records'**
  String get viewRecords;

  /// No description provided for @financial.
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get financial;

  /// No description provided for @viewIncome.
  ///
  /// In en, this message translates to:
  /// **'View income'**
  String get viewIncome;

  /// No description provided for @specialOffers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get specialOffers;

  /// No description provided for @stayUpdated.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with your practice'**
  String get stayUpdated;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get markAllAsRead;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read'**
  String get markAsRead;

  /// No description provided for @notificationManagementTips.
  ///
  /// In en, this message translates to:
  /// **'Notification Management Tips'**
  String get notificationManagementTips;

  /// No description provided for @tip1.
  ///
  /// In en, this message translates to:
  /// **'Enable push notifications to respond to urgent patient requests quickly'**
  String get tip1;

  /// No description provided for @tip2.
  ///
  /// In en, this message translates to:
  /// **'High priority notifications require immediate attention'**
  String get tip2;

  /// No description provided for @tip3.
  ///
  /// In en, this message translates to:
  /// **'Customize notification preferences in Settings'**
  String get tip3;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @proDoctor.
  ///
  /// In en, this message translates to:
  /// **'Pro Doctor'**
  String get proDoctor;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @clinicsManagement.
  ///
  /// In en, this message translates to:
  /// **'Clinics Management'**
  String get clinicsManagement;

  /// No description provided for @addAllClinicsWhereYouPractice.
  ///
  /// In en, this message translates to:
  /// **'Add all clinics where you practice'**
  String get addAllClinicsWhereYouPractice;

  /// No description provided for @addClinic.
  ///
  /// In en, this message translates to:
  /// **'Add Clinic'**
  String get addClinic;

  /// No description provided for @addClinicTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Clinic'**
  String get addClinicTitle;

  /// No description provided for @servicesAndPricing.
  ///
  /// In en, this message translates to:
  /// **'Services & Pricing'**
  String get servicesAndPricing;

  /// No description provided for @clinicVisit.
  ///
  /// In en, this message translates to:
  /// **'Clinic Visit'**
  String get clinicVisit;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @videoCall.
  ///
  /// In en, this message translates to:
  /// **'Video Call'**
  String get videoCall;

  /// No description provided for @followUp.
  ///
  /// In en, this message translates to:
  /// **'Follow-up'**
  String get followUp;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bankTransfer;

  /// No description provided for @mobileWallet.
  ///
  /// In en, this message translates to:
  /// **'Mobile Wallet'**
  String get mobileWallet;

  /// No description provided for @directDepositToLocalBank.
  ///
  /// In en, this message translates to:
  /// **'Direct deposit to local bank'**
  String get directDepositToLocalBank;

  /// No description provided for @instantTransferToDigitalWallet.
  ///
  /// In en, this message translates to:
  /// **'Instant transfer to digital wallet'**
  String get instantTransferToDigitalWallet;

  /// No description provided for @accountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accountHolderName;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save Profile'**
  String get saveProfile;

  /// No description provided for @clinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get clinic;

  /// No description provided for @locationNotSet.
  ///
  /// In en, this message translates to:
  /// **'Location not set'**
  String get locationNotSet;

  /// No description provided for @homeVisit.
  ///
  /// In en, this message translates to:
  /// **'Home Visit'**
  String get homeVisit;

  /// No description provided for @socialMediaMarketing.
  ///
  /// In en, this message translates to:
  /// **'Social Media Marketing'**
  String get socialMediaMarketing;

  /// No description provided for @rujetaSocialMediaMarketing.
  ///
  /// In en, this message translates to:
  /// **'Rujeta Social Media Marketing'**
  String get rujetaSocialMediaMarketing;

  /// No description provided for @marketingIntroDesc.
  ///
  /// In en, this message translates to:
  /// **'Increase your visibility and attract more patients through our official social media channels with over 500K+ followers.'**
  String get marketingIntroDesc;

  /// No description provided for @profContentCreation.
  ///
  /// In en, this message translates to:
  /// **'Professional content creation'**
  String get profContentCreation;

  /// No description provided for @targetedAudienceReach.
  ///
  /// In en, this message translates to:
  /// **'Targeted audience reach'**
  String get targetedAudienceReach;

  /// No description provided for @perfTrackingAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Performance tracking & analytics'**
  String get perfTrackingAnalytics;

  /// No description provided for @brandBuildingCredibility.
  ///
  /// In en, this message translates to:
  /// **'Brand building & credibility'**
  String get brandBuildingCredibility;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @myPlan.
  ///
  /// In en, this message translates to:
  /// **'My Plan'**
  String get myPlan;

  /// No description provided for @activePlan.
  ///
  /// In en, this message translates to:
  /// **'Active Plan'**
  String get activePlan;

  /// No description provided for @postsUsed.
  ///
  /// In en, this message translates to:
  /// **'Posts Used'**
  String get postsUsed;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'Days Remaining'**
  String get daysRemaining;

  /// No description provided for @yourBenefits.
  ///
  /// In en, this message translates to:
  /// **'Your Benefits'**
  String get yourBenefits;

  /// No description provided for @benefit1.
  ///
  /// In en, this message translates to:
  /// **'12 social media posts per month'**
  String get benefit1;

  /// No description provided for @benefit2.
  ///
  /// In en, this message translates to:
  /// **'Professional design & content'**
  String get benefit2;

  /// No description provided for @benefit3.
  ///
  /// In en, this message translates to:
  /// **'Facebook, Instagram & Twitter'**
  String get benefit3;

  /// No description provided for @benefit4.
  ///
  /// In en, this message translates to:
  /// **'Weekly performance reports'**
  String get benefit4;

  /// No description provided for @benefit5.
  ///
  /// In en, this message translates to:
  /// **'Priority posting times'**
  String get benefit5;

  /// No description provided for @previousPlan.
  ///
  /// In en, this message translates to:
  /// **'Previous Plan'**
  String get previousPlan;

  /// No description provided for @seeDetails.
  ///
  /// In en, this message translates to:
  /// **'See Details'**
  String get seeDetails;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @save17.
  ///
  /// In en, this message translates to:
  /// **'Save 17% with yearly billing'**
  String get save17;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get subscribeNow;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR'**
  String get mostPopular;

  /// No description provided for @basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// No description provided for @professional.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get professional;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @postsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'posts/month'**
  String get postsPerMonth;

  /// No description provided for @egpPerYear.
  ///
  /// In en, this message translates to:
  /// **'EGP /year'**
  String get egpPerYear;

  /// No description provided for @designQuality.
  ///
  /// In en, this message translates to:
  /// **'Design Quality'**
  String get designQuality;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @confirmSubscription.
  ///
  /// In en, this message translates to:
  /// **'Confirm Subscription'**
  String get confirmSubscription;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @financialManagement.
  ///
  /// In en, this message translates to:
  /// **'Financial Management'**
  String get financialManagement;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @netIncome.
  ///
  /// In en, this message translates to:
  /// **'Net Income'**
  String get netIncome;

  /// No description provided for @breakdown.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get breakdown;

  /// No description provided for @totalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// No description provided for @platformCommission.
  ///
  /// In en, this message translates to:
  /// **'Platform Commission'**
  String get platformCommission;

  /// No description provided for @yourNetIncome.
  ///
  /// In en, this message translates to:
  /// **'Your Net Income'**
  String get yourNetIncome;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @yourEarning.
  ///
  /// In en, this message translates to:
  /// **'Your Earning'**
  String get yourEarning;

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completedStatus;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get pendingStatus;

  /// No description provided for @paymentScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Schedule'**
  String get paymentScheduleTitle;

  /// No description provided for @paymentScheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'Net income is transferred to your registered bank account within 3-5 business days after each appointment completion.'**
  String get paymentScheduleDesc;

  /// No description provided for @clinicName.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name *'**
  String get clinicName;

  /// No description provided for @clinicNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Cairo Medical Center'**
  String get clinicNameHint;

  /// No description provided for @clinicPhone.
  ///
  /// In en, this message translates to:
  /// **'Clinic Phone *'**
  String get clinicPhone;

  /// No description provided for @clinicPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'02xxxxxxxx'**
  String get clinicPhoneHint;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate *'**
  String get governorate;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City *'**
  String get city;

  /// No description provided for @fullAddress.
  ///
  /// In en, this message translates to:
  /// **'Full Address *'**
  String get fullAddress;

  /// No description provided for @fullAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Street, building number, floor, etc.'**
  String get fullAddressHint;

  /// No description provided for @clinicPhotos.
  ///
  /// In en, this message translates to:
  /// **'Clinic Photos'**
  String get clinicPhotos;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @uploadUpTo6Photos.
  ///
  /// In en, this message translates to:
  /// **'Upload up to 6 photos of your clinic'**
  String get uploadUpTo6Photos;

  /// No description provided for @consultationTime.
  ///
  /// In en, this message translates to:
  /// **'Consultation Time'**
  String get consultationTime;

  /// No description provided for @consultationTimeHint.
  ///
  /// In en, this message translates to:
  /// **'30 minute'**
  String get consultationTimeHint;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @servicesAndPricingAtClinic.
  ///
  /// In en, this message translates to:
  /// **'Services & Pricing at this Clinic'**
  String get servicesAndPricingAtClinic;

  /// No description provided for @additionalServicesAndPricing.
  ///
  /// In en, this message translates to:
  /// **'Additional Services & Pricing'**
  String get additionalServicesAndPricing;

  /// No description provided for @additionalServicesDesc.
  ///
  /// In en, this message translates to:
  /// **'These services are not tied to a specific clinic location'**
  String get additionalServicesDesc;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @totalPatients.
  ///
  /// In en, this message translates to:
  /// **'Total Patients'**
  String get totalPatients;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue (EGP)'**
  String get totalRevenue;

  /// No description provided for @netIncomeEgp.
  ///
  /// In en, this message translates to:
  /// **'Net Income (EGP)'**
  String get netIncomeEgp;

  /// No description provided for @totalAppointments.
  ///
  /// In en, this message translates to:
  /// **'Total Appointments'**
  String get totalAppointments;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @returningLabel.
  ///
  /// In en, this message translates to:
  /// **'Returning'**
  String get returningLabel;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @avgPerPatient.
  ///
  /// In en, this message translates to:
  /// **'Avg per patient'**
  String get avgPerPatient;

  /// No description provided for @appointmentsByType.
  ///
  /// In en, this message translates to:
  /// **'Appointments by Type'**
  String get appointmentsByType;

  /// No description provided for @weeklyPerformance.
  ///
  /// In en, this message translates to:
  /// **'Weekly Performance'**
  String get weeklyPerformance;

  /// No description provided for @patientsLabel.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patientsLabel;

  /// No description provided for @revenueLabel.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenueLabel;

  /// No description provided for @performanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get performanceSummary;

  /// No description provided for @patientGrowth.
  ///
  /// In en, this message translates to:
  /// **'Patient Growth'**
  String get patientGrowth;

  /// No description provided for @revenueGrowth.
  ///
  /// In en, this message translates to:
  /// **'Revenue Growth'**
  String get revenueGrowth;

  /// No description provided for @successRate.
  ///
  /// In en, this message translates to:
  /// **'Success Rate'**
  String get successRate;

  /// No description provided for @avgRevenuePerPatient.
  ///
  /// In en, this message translates to:
  /// **'Avg. Revenue/Patient'**
  String get avgRevenuePerPatient;

  /// No description provided for @medicalConsultation.
  ///
  /// In en, this message translates to:
  /// **'Medical Consultation'**
  String get medicalConsultation;

  /// No description provided for @startConsultation.
  ///
  /// In en, this message translates to:
  /// **'Start Consultation'**
  String get startConsultation;

  /// No description provided for @diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis *'**
  String get diagnosis;

  /// No description provided for @enterDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Enter diagnosis..'**
  String get enterDiagnosis;

  /// No description provided for @medicalNotes.
  ///
  /// In en, this message translates to:
  /// **'Medical Notes'**
  String get medicalNotes;

  /// No description provided for @prescriptionImgHere.
  ///
  /// In en, this message translates to:
  /// **'prescription img here'**
  String get prescriptionImgHere;

  /// No description provided for @openBtn.
  ///
  /// In en, this message translates to:
  /// **'open'**
  String get openBtn;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @uploadPdf.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF'**
  String get uploadPdf;

  /// No description provided for @medicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Medication name, dosage, frequency, duration...'**
  String get medicationDetails;

  /// No description provided for @laboratoryTests.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Tests'**
  String get laboratoryTests;

  /// No description provided for @requiredLabTests.
  ///
  /// In en, this message translates to:
  /// **'Required lab tests (e.g., CBC, Lipid Profile, HbA1c)..'**
  String get requiredLabTests;

  /// No description provided for @radiologyTests.
  ///
  /// In en, this message translates to:
  /// **'Radiology Tests'**
  String get radiologyTests;

  /// No description provided for @requiredRadiologyTests.
  ///
  /// In en, this message translates to:
  /// **'Required radiology tests (e.g., X-Ray, CT Scan, MRI)..'**
  String get requiredRadiologyTests;

  /// No description provided for @followUpDate.
  ///
  /// In en, this message translates to:
  /// **'Follow-up Date'**
  String get followUpDate;

  /// No description provided for @saveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get saveDraft;

  /// No description provided for @completeBtn.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completeBtn;

  /// No description provided for @myPatients.
  ///
  /// In en, this message translates to:
  /// **'My Patients'**
  String get myPatients;

  /// No description provided for @searchByNameOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Search by name or phone...'**
  String get searchByNameOrPhone;

  /// No description provided for @visits.
  ///
  /// In en, this message translates to:
  /// **'visits'**
  String get visits;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @lastVisit.
  ///
  /// In en, this message translates to:
  /// **'Last Visit'**
  String get lastVisit;

  /// No description provided for @lastDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Last Diagnosis'**
  String get lastDiagnosis;

  /// No description provided for @patientDetails.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patientDetails;

  /// No description provided for @medicalInformation.
  ///
  /// In en, this message translates to:
  /// **'Medical Information'**
  String get medicalInformation;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @chronicConditions.
  ///
  /// In en, this message translates to:
  /// **'Chronic Conditions'**
  String get chronicConditions;

  /// No description provided for @visitHistory.
  ///
  /// In en, this message translates to:
  /// **'Visit History'**
  String get visitHistory;

  /// No description provided for @laboratoryResults.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Results'**
  String get laboratoryResults;

  /// No description provided for @testsPerformed.
  ///
  /// In en, this message translates to:
  /// **'Tests Performed'**
  String get testsPerformed;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @addSlot.
  ///
  /// In en, this message translates to:
  /// **'Add Slot'**
  String get addSlot;

  /// No description provided for @saveWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'Save Working Hours'**
  String get saveWorkingHours;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @vacationsAndUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Vacations and Unavailable Days'**
  String get vacationsAndUnavailable;

  /// No description provided for @scheduleManagement.
  ///
  /// In en, this message translates to:
  /// **'Schedule Management'**
  String get scheduleManagement;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFound;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error Occurred'**
  String get errorOccurred;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @addSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Add Specialty'**
  String get addSpecialty;

  /// No description provided for @addNewSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Add new specialty'**
  String get addNewSpecialty;

  /// No description provided for @addDoctor.
  ///
  /// In en, this message translates to:
  /// **'+ ADD DOCTOR'**
  String get addDoctor;

  /// No description provided for @addNewDoctor.
  ///
  /// In en, this message translates to:
  /// **'Add new Doctor'**
  String get addNewDoctor;

  /// No description provided for @viewEarnings.
  ///
  /// In en, this message translates to:
  /// **'View Earnings'**
  String get viewEarnings;

  /// No description provided for @depts.
  ///
  /// In en, this message translates to:
  /// **'Depts'**
  String get depts;

  /// No description provided for @medicalServicesManagement.
  ///
  /// In en, this message translates to:
  /// **'Medical Services Management'**
  String get medicalServicesManagement;

  /// No description provided for @manageMedicalServices.
  ///
  /// In en, this message translates to:
  /// **'Manage Medical Services'**
  String get manageMedicalServices;

  /// No description provided for @medicalServicesDesc.
  ///
  /// In en, this message translates to:
  /// **'Add new specialties and update doctors\' and nursing staff information to improve the patient experience.'**
  String get medicalServicesDesc;

  /// No description provided for @welcomeBackHospital.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBackHospital;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chooseOnMap.
  ///
  /// In en, this message translates to:
  /// **'Choose on map'**
  String get chooseOnMap;

  /// No description provided for @organizationName.
  ///
  /// In en, this message translates to:
  /// **'Organization Name *'**
  String get organizationName;

  /// No description provided for @organizationNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Cairo Medical Center'**
  String get organizationNameHint;

  /// No description provided for @organizationType.
  ///
  /// In en, this message translates to:
  /// **'Organization Type *'**
  String get organizationType;

  /// No description provided for @organizationTypeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Private Clinic, General Hospital'**
  String get organizationTypeHint;

  /// No description provided for @organizationNumber.
  ///
  /// In en, this message translates to:
  /// **'Organization Number *'**
  String get organizationNumber;

  /// No description provided for @organizationNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 01X XXXXXXXX'**
  String get organizationNumberHint;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number *'**
  String get licenseNumber;

  /// No description provided for @licenseNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., ORG-12345'**
  String get licenseNumberHint;

  /// No description provided for @organizationAboutHint.
  ///
  /// In en, this message translates to:
  /// **'Brief description about your organization and services...'**
  String get organizationAboutHint;

  /// No description provided for @organizationLogo.
  ///
  /// In en, this message translates to:
  /// **'Organization Logo'**
  String get organizationLogo;

  /// No description provided for @organizationImages.
  ///
  /// In en, this message translates to:
  /// **'Organization Images'**
  String get organizationImages;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @yourPaymentDetailsAreSecure.
  ///
  /// In en, this message translates to:
  /// **'Your payment details are secure'**
  String get yourPaymentDetailsAreSecure;

  /// No description provided for @taxId.
  ///
  /// In en, this message translates to:
  /// **'Tax ID'**
  String get taxId;

  /// No description provided for @basicRadiologyInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Radiology Information'**
  String get basicRadiologyInformation;

  /// No description provided for @basicLaboratoryInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Laboratory Information'**
  String get basicLaboratoryInformation;

  /// No description provided for @basicNursingCareInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Nursing Care Information'**
  String get basicNursingCareInformation;

  /// No description provided for @radiologyName.
  ///
  /// In en, this message translates to:
  /// **'Radiology Name *'**
  String get radiologyName;

  /// No description provided for @laboratoryName.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Name *'**
  String get laboratoryName;

  /// No description provided for @nursingCareName.
  ///
  /// In en, this message translates to:
  /// **'Nursing Care Name *'**
  String get nursingCareName;

  /// No description provided for @homeSampleCollection.
  ///
  /// In en, this message translates to:
  /// **'Home Sample Collection'**
  String get homeSampleCollection;

  /// No description provided for @availableForHomeSampleCollection.
  ///
  /// In en, this message translates to:
  /// **'Available for Home Sample Collection'**
  String get availableForHomeSampleCollection;

  /// No description provided for @homeSampleCollectionFee.
  ///
  /// In en, this message translates to:
  /// **'Home Sample Collection Fee (EGP) *'**
  String get homeSampleCollectionFee;

  /// No description provided for @homeSampleCollectionFeeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 50'**
  String get homeSampleCollectionFeeHint;

  /// No description provided for @serviceAreaRadius.
  ///
  /// In en, this message translates to:
  /// **'Service Area Radius (km) *'**
  String get serviceAreaRadius;

  /// No description provided for @serviceAreaRadiusHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 20'**
  String get serviceAreaRadiusHint;

  /// No description provided for @nursingLogo.
  ///
  /// In en, this message translates to:
  /// **'Nursing Logo'**
  String get nursingLogo;

  /// No description provided for @radiologyLogo.
  ///
  /// In en, this message translates to:
  /// **'Radiology Logo'**
  String get radiologyLogo;

  /// No description provided for @laboratoryLogo.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Logo'**
  String get laboratoryLogo;

  /// No description provided for @centerImages.
  ///
  /// In en, this message translates to:
  /// **'Center Images'**
  String get centerImages;

  /// No description provided for @workingHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Working Hours *'**
  String get workingHoursTitle;

  /// No description provided for @open24_7.
  ///
  /// In en, this message translates to:
  /// **'Open 24/7'**
  String get open24_7;

  /// No description provided for @addAnotherWorkingDay.
  ///
  /// In en, this message translates to:
  /// **'Add another working day'**
  String get addAnotherWorkingDay;

  /// No description provided for @medicalServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical Services'**
  String get medicalServicesTitle;

  /// No description provided for @manageSpecialtiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage specialties, doctors, and nursing staff.'**
  String get manageSpecialtiesSubtitle;

  /// No description provided for @activeSpecialties.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE SPECIALTIES'**
  String get activeSpecialties;

  /// No description provided for @totalStaff.
  ///
  /// In en, this message translates to:
  /// **'TOTAL STAFF'**
  String get totalStaff;

  /// No description provided for @hospitalSetupProgress.
  ///
  /// In en, this message translates to:
  /// **'Hospital Setup Progress'**
  String get hospitalSetupProgress;

  /// No description provided for @addYourFirstSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Add your first specialty'**
  String get addYourFirstSpecialty;

  /// No description provided for @addDoctorsProgress.
  ///
  /// In en, this message translates to:
  /// **'Add doctors'**
  String get addDoctorsProgress;

  /// No description provided for @startReceivingBookings.
  ///
  /// In en, this message translates to:
  /// **'Start receiving bookings'**
  String get startReceivingBookings;

  /// No description provided for @servicesNotSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Your medical services are not set up yet'**
  String get servicesNotSetupTitle;

  /// No description provided for @servicesNotSetupDesc.
  ///
  /// In en, this message translates to:
  /// **'Add specialties, doctors, and nursing staff to make your hospital visible to patients.'**
  String get servicesNotSetupDesc;

  /// No description provided for @addYourFirstSpecialtyBtn.
  ///
  /// In en, this message translates to:
  /// **'+ Add Your First Specialty'**
  String get addYourFirstSpecialtyBtn;

  /// No description provided for @enableServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable the services available in your hospital.'**
  String get enableServicesTitle;

  /// No description provided for @serviceLaboratory.
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get serviceLaboratory;

  /// No description provided for @serviceLaboratoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Provide lab tests and sample collection.'**
  String get serviceLaboratoryDesc;

  /// No description provided for @serviceClinics.
  ///
  /// In en, this message translates to:
  /// **'Clinics'**
  String get serviceClinics;

  /// No description provided for @serviceClinicsDesc.
  ///
  /// In en, this message translates to:
  /// **'Variety of Clinics for all services'**
  String get serviceClinicsDesc;

  /// No description provided for @serviceRadiology.
  ///
  /// In en, this message translates to:
  /// **'Radiology'**
  String get serviceRadiology;

  /// No description provided for @serviceRadiologyDesc.
  ///
  /// In en, this message translates to:
  /// **'Imaging and scan services.'**
  String get serviceRadiologyDesc;

  /// No description provided for @serviceAmbulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get serviceAmbulance;

  /// No description provided for @serviceAmbulanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Emergency transportation services.'**
  String get serviceAmbulanceDesc;

  /// No description provided for @serviceICU.
  ///
  /// In en, this message translates to:
  /// **'ICU'**
  String get serviceICU;

  /// No description provided for @serviceICUDesc.
  ///
  /// In en, this message translates to:
  /// **'Intensive care unit availability.'**
  String get serviceICUDesc;

  /// No description provided for @totalIcuBeds.
  ///
  /// In en, this message translates to:
  /// **'Total ICU Beds'**
  String get totalIcuBeds;

  /// No description provided for @serviceIncubators.
  ///
  /// In en, this message translates to:
  /// **'Incubators'**
  String get serviceIncubators;

  /// No description provided for @serviceIncubatorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Neonatal Incubator services.'**
  String get serviceIncubatorsDesc;

  /// No description provided for @serviceHomeCare.
  ///
  /// In en, this message translates to:
  /// **'Home Care'**
  String get serviceHomeCare;

  /// No description provided for @serviceHomeCareDesc.
  ///
  /// In en, this message translates to:
  /// **'At home healthcare services.'**
  String get serviceHomeCareDesc;

  /// No description provided for @addSpecialtyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Specialty'**
  String get addSpecialtyTitle;

  /// No description provided for @specialtyDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Specialty Details'**
  String get specialtyDetailsTitle;

  /// No description provided for @specialtyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Specialty Name'**
  String get specialtyNameLabel;

  /// No description provided for @shortDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Short Description (optional)'**
  String get shortDescriptionLabel;

  /// No description provided for @shortDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Briefly describe the services offered within this specialty...'**
  String get shortDescriptionHint;

  /// No description provided for @emergencyServicesAvailable.
  ///
  /// In en, this message translates to:
  /// **'Emergency Services Available'**
  String get emergencyServicesAvailable;

  /// No description provided for @emergencyServicesDesc.
  ///
  /// In en, this message translates to:
  /// **'Check if this department handles urgent care'**
  String get emergencyServicesDesc;

  /// No description provided for @addSpecialtyInfoBox.
  ///
  /// In en, this message translates to:
  /// **'Adding a specialty will allow you to assign specific doctors and consultation hours to this department in the next step.'**
  String get addSpecialtyInfoBox;

  /// No description provided for @saveAndAddDoctors.
  ///
  /// In en, this message translates to:
  /// **'Save & Add Doctors ->'**
  String get saveAndAddDoctors;

  /// No description provided for @addAnotherSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Add Another Specialty'**
  String get addAnotherSpecialty;

  /// No description provided for @nurses.
  ///
  /// In en, this message translates to:
  /// **'Nurses'**
  String get nurses;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @addSpecialtyBtn.
  ///
  /// In en, this message translates to:
  /// **'+ ADD SPECIALTY'**
  String get addSpecialtyBtn;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addDoctorTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Doctor'**
  String get addDoctorTitle;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'UPLOAD PHOTO'**
  String get uploadPhoto;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullNameLabel;

  /// No description provided for @professionalTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'PROFESSIONAL TITLE'**
  String get professionalTitleLabel;

  /// No description provided for @professionalTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Consultant Cardiologist'**
  String get professionalTitleHint;

  /// No description provided for @medicalLicenseNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'MEDICAL LICENSE NUMBER'**
  String get medicalLicenseNumberLabel;

  /// No description provided for @medicalLicenseNumberHint.
  ///
  /// In en, this message translates to:
  /// **'MD-12345678'**
  String get medicalLicenseNumberHint;

  /// No description provided for @yearsOfExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'YEARS OF EXPERIENCE'**
  String get yearsOfExperienceLabel;

  /// No description provided for @consultationFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFeeLabel;

  /// No description provided for @consultationFeeHint.
  ///
  /// In en, this message translates to:
  /// **'130'**
  String get consultationFeeHint;

  /// No description provided for @availableDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Available Days'**
  String get availableDaysLabel;

  /// No description provided for @availableDaysHint.
  ///
  /// In en, this message translates to:
  /// **'Sat , Mon'**
  String get availableDaysHint;

  /// No description provided for @consultationDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Consultation Duration'**
  String get consultationDurationLabel;

  /// No description provided for @consultationDurationHint.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get consultationDurationHint;

  /// No description provided for @shortBioLabel.
  ///
  /// In en, this message translates to:
  /// **'SHORT BIO'**
  String get shortBioLabel;

  /// No description provided for @shortBioHint.
  ///
  /// In en, this message translates to:
  /// **'Brief professional background and achievements...'**
  String get shortBioHint;

  /// No description provided for @doctorDirectoryNotice.
  ///
  /// In en, this message translates to:
  /// **'This information will be visible to patients and other staff members in the medical directory once verified.'**
  String get doctorDirectoryNotice;

  /// No description provided for @saveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveBtn;

  /// No description provided for @addAnotherDoctorBtn.
  ///
  /// In en, this message translates to:
  /// **'Add Another Doctor'**
  String get addAnotherDoctorBtn;

  /// No description provided for @doctorAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Doctor added successfully'**
  String get doctorAddedSuccessfully;

  /// No description provided for @laboratoryManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Management'**
  String get laboratoryManagementTitle;

  /// No description provided for @laboratoryServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Add lab tests, prices, and home collection options for your patients.'**
  String get laboratoryServiceDesc;

  /// No description provided for @addTestBtn.
  ///
  /// In en, this message translates to:
  /// **'+ Add Test'**
  String get addTestBtn;

  /// No description provided for @addNewTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Test'**
  String get addNewTestTitle;

  /// No description provided for @testNameLabel.
  ///
  /// In en, this message translates to:
  /// **'TEST NAME'**
  String get testNameLabel;

  /// No description provided for @testNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Complete Blood Count'**
  String get testNameHint;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get categoryLabel;

  /// No description provided for @priceEgpLabel.
  ///
  /// In en, this message translates to:
  /// **'PRICE (EGP)'**
  String get priceEgpLabel;

  /// No description provided for @homeCollectionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Home Collection Available'**
  String get homeCollectionAvailable;

  /// No description provided for @technicianVisitAddress.
  ///
  /// In en, this message translates to:
  /// **'Technician can visit patient address'**
  String get technicianVisitAddress;

  /// No description provided for @preparationInstructionsOptional.
  ///
  /// In en, this message translates to:
  /// **'PREPARATION INSTRUCTIONS (OPTIONAL)'**
  String get preparationInstructionsOptional;

  /// No description provided for @preparationInstructionsVisibleToPatient.
  ///
  /// In en, this message translates to:
  /// **'These instructions will be visible to the patient during booking.'**
  String get preparationInstructionsVisibleToPatient;

  /// No description provided for @estimatedResultTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'ESTIMATED RESULT TIME'**
  String get estimatedResultTimeLabel;

  /// No description provided for @saveTestBtn.
  ///
  /// In en, this message translates to:
  /// **'Save Test'**
  String get saveTestBtn;

  /// No description provided for @activeLabTestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Lab Tests'**
  String get activeLabTestsTitle;

  /// No description provided for @radiologyManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Radiology Management'**
  String get radiologyManagementTitle;

  /// No description provided for @radiologyServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage scans, X-rays, and imaging services for your patients with high precision and clinical clarity.'**
  String get radiologyServiceDesc;

  /// No description provided for @addRadiologyServiceBtn.
  ///
  /// In en, this message translates to:
  /// **'+ ADD RADIOLOGY SERVICE'**
  String get addRadiologyServiceBtn;

  /// No description provided for @addNewServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Service'**
  String get addNewServiceTitle;

  /// No description provided for @serviceNameLabel.
  ///
  /// In en, this message translates to:
  /// **'SERVICE NAME'**
  String get serviceNameLabel;

  /// No description provided for @serviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. MRI, X-Ray'**
  String get serviceNameHint;

  /// No description provided for @contrastAgentRequired.
  ///
  /// In en, this message translates to:
  /// **'Contrast Agent Required'**
  String get contrastAgentRequired;

  /// No description provided for @requiresContrastDesc.
  ///
  /// In en, this message translates to:
  /// **'Does this test require contrast?'**
  String get requiresContrastDesc;

  /// No description provided for @preparationInstructionsLabel.
  ///
  /// In en, this message translates to:
  /// **'PREPARATION INSTRUCTIONS'**
  String get preparationInstructionsLabel;

  /// No description provided for @estimatedDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'ESTIMATED DURATION'**
  String get estimatedDurationLabel;

  /// No description provided for @saveServiceBtn.
  ///
  /// In en, this message translates to:
  /// **'SAVE SERVICE'**
  String get saveServiceBtn;

  /// No description provided for @activeServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE SERVICES'**
  String get activeServicesTitle;

  /// No description provided for @noContrast.
  ///
  /// In en, this message translates to:
  /// **'NO CONTRAST'**
  String get noContrast;

  /// No description provided for @contrastAvailable.
  ///
  /// In en, this message translates to:
  /// **'CONTRAST AVAILABLE'**
  String get contrastAvailable;

  /// No description provided for @icuManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'ICU Management'**
  String get icuManagementTitle;

  /// No description provided for @icuServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor ICU room status and bed availability.'**
  String get icuServiceDesc;

  /// No description provided for @addRoomBedBtn.
  ///
  /// In en, this message translates to:
  /// **'+ Add Room/Bed'**
  String get addRoomBedBtn;

  /// No description provided for @totalUnits.
  ///
  /// In en, this message translates to:
  /// **'TOTAL UNITS'**
  String get totalUnits;

  /// No description provided for @inUse.
  ///
  /// In en, this message translates to:
  /// **'IN USE'**
  String get inUse;

  /// No description provided for @addNewIcuRoomTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New ICU Room'**
  String get addNewIcuRoomTitle;

  /// No description provided for @roomNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Room Number'**
  String get roomNumberLabel;

  /// No description provided for @roomNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. ICU-402'**
  String get roomNumberHint;

  /// No description provided for @bedIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Bed ID'**
  String get bedIdLabel;

  /// No description provided for @bedIdHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. B-12'**
  String get bedIdHint;

  /// No description provided for @floorWingLabel.
  ///
  /// In en, this message translates to:
  /// **'Floor / Wing'**
  String get floorWingLabel;

  /// No description provided for @selectLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocationHint;

  /// No description provided for @equipmentListLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment List'**
  String get equipmentListLabel;

  /// No description provided for @ventilator.
  ///
  /// In en, this message translates to:
  /// **'Ventilator'**
  String get ventilator;

  /// No description provided for @infusionPump.
  ///
  /// In en, this message translates to:
  /// **'Infusion Pump'**
  String get infusionPump;

  /// No description provided for @vitalsMonitor.
  ///
  /// In en, this message translates to:
  /// **'Vitals Monitor'**
  String get vitalsMonitor;

  /// No description provided for @defibrillator.
  ///
  /// In en, this message translates to:
  /// **'Defibrillator'**
  String get defibrillator;

  /// No description provided for @registerRoomBtn.
  ///
  /// In en, this message translates to:
  /// **'Register Room'**
  String get registerRoomBtn;

  /// No description provided for @activeIcuRoomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Active ICU Rooms'**
  String get activeIcuRoomsTitle;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// No description provided for @cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// No description provided for @noPatientAssigned.
  ///
  /// In en, this message translates to:
  /// **'No patient assigned'**
  String get noPatientAssigned;

  /// No description provided for @incubatorManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Incubator Management'**
  String get incubatorManagementTitle;

  /// No description provided for @incubatorServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage NICU equipment and monitoring units.'**
  String get incubatorServiceDesc;

  /// No description provided for @addNewIncubatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Incubator'**
  String get addNewIncubatorTitle;

  /// No description provided for @unitIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit ID'**
  String get unitIdLabel;

  /// No description provided for @unitIdHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. NICU-001'**
  String get unitIdHint;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get modelLabel;

  /// No description provided for @wingSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Wing / Section'**
  String get wingSectionLabel;

  /// No description provided for @monitoringTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Monitoring Type'**
  String get monitoringTypeLabel;

  /// No description provided for @vitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get vitals;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// No description provided for @registerUnitBtn.
  ///
  /// In en, this message translates to:
  /// **'Register Unit'**
  String get registerUnitBtn;

  /// No description provided for @activeUnitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Units'**
  String get activeUnitsTitle;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'READY'**
  String get ready;

  /// No description provided for @temp.
  ///
  /// In en, this message translates to:
  /// **'TEMP'**
  String get temp;

  /// No description provided for @hum.
  ///
  /// In en, this message translates to:
  /// **'HUM'**
  String get hum;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @hospitalInformation.
  ///
  /// In en, this message translates to:
  /// **'Hospital Information'**
  String get hospitalInformation;

  /// No description provided for @workingHoursSettings.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHoursSettings;

  /// No description provided for @newBookings.
  ///
  /// In en, this message translates to:
  /// **'New Bookings'**
  String get newBookings;

  /// No description provided for @newBookingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Notify me of incoming patient appointments'**
  String get newBookingsDesc;

  /// No description provided for @emergencyRequests.
  ///
  /// In en, this message translates to:
  /// **'Emergency Requests'**
  String get emergencyRequests;

  /// No description provided for @emergencyRequestsDesc.
  ///
  /// In en, this message translates to:
  /// **'Immediate alerts for urgent patient care'**
  String get emergencyRequestsDesc;

  /// No description provided for @paymentNotifications.
  ///
  /// In en, this message translates to:
  /// **'Payment Notifications'**
  String get paymentNotifications;

  /// No description provided for @paymentNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Alerts for completed transactions'**
  String get paymentNotificationsDesc;

  /// No description provided for @reportAProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get reportAProblem;

  /// No description provided for @deactivateAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get deactivateAccount;

  /// No description provided for @alertPreferences.
  ///
  /// In en, this message translates to:
  /// **'Alert Preferences'**
  String get alertPreferences;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @marketingContactText.
  ///
  /// In en, this message translates to:
  /// **'For marketing services contact us via our '**
  String get marketingContactText;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'support team'**
  String get supportTeam;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @marketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get marketing;

  /// No description provided for @tests.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get tests;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @cityScan.
  ///
  /// In en, this message translates to:
  /// **'City Scan'**
  String get cityScan;

  /// No description provided for @welcomeCityScan.
  ///
  /// In en, this message translates to:
  /// **'Welcome, City Scan'**
  String get welcomeCityScan;

  /// No description provided for @addScan.
  ///
  /// In en, this message translates to:
  /// **'Add Scan'**
  String get addScan;

  /// No description provided for @scans.
  ///
  /// In en, this message translates to:
  /// **'Scans'**
  String get scans;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @cityLab.
  ///
  /// In en, this message translates to:
  /// **'City Lab'**
  String get cityLab;

  /// No description provided for @welcomeCityLab.
  ///
  /// In en, this message translates to:
  /// **'Welcome, City Lab'**
  String get welcomeCityLab;

  /// No description provided for @radiologyScanTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Radiology Scan'**
  String get radiologyScanTabTitle;

  /// No description provided for @laboratoryTestsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Tests'**
  String get laboratoryTestsTabTitle;

  /// No description provided for @manageTestMenu.
  ///
  /// In en, this message translates to:
  /// **'Manage your test menu, pricing, and availability.'**
  String get manageTestMenu;

  /// No description provided for @manageServiceMenu.
  ///
  /// In en, this message translates to:
  /// **'Manage your service menu, pricing, and availability.'**
  String get manageServiceMenu;

  /// No description provided for @totalActiveTests.
  ///
  /// In en, this message translates to:
  /// **'TOTAL ACTIVE TESTS'**
  String get totalActiveTests;

  /// No description provided for @totalActiveScans.
  ///
  /// In en, this message translates to:
  /// **'TOTAL ACTIVE Scans'**
  String get totalActiveScans;

  /// No description provided for @activeLabTests.
  ///
  /// In en, this message translates to:
  /// **'Active Lab Tests'**
  String get activeLabTests;

  /// No description provided for @activeRadiologyScan.
  ///
  /// In en, this message translates to:
  /// **'Active Radiology Scan'**
  String get activeRadiologyScan;

  /// No description provided for @homeCollection.
  ///
  /// In en, this message translates to:
  /// **'Home Collection'**
  String get homeCollection;

  /// No description provided for @addNewTest.
  ///
  /// In en, this message translates to:
  /// **'Add New Test'**
  String get addNewTest;

  /// No description provided for @addNewScan.
  ///
  /// In en, this message translates to:
  /// **'Add New Scan'**
  String get addNewScan;

  /// No description provided for @testName.
  ///
  /// In en, this message translates to:
  /// **'Test Name'**
  String get testName;

  /// No description provided for @scanName.
  ///
  /// In en, this message translates to:
  /// **'Scan Name'**
  String get scanName;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @priceEgp.
  ///
  /// In en, this message translates to:
  /// **'Price (EGP)'**
  String get priceEgp;

  /// No description provided for @turnaroundTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Turnaround Time (e.g., 24 hours)'**
  String get turnaroundTimeLabel;

  /// No description provided for @preparationsOptional.
  ///
  /// In en, this message translates to:
  /// **'Preparations (Optional)'**
  String get preparationsOptional;

  /// No description provided for @saveService.
  ///
  /// In en, this message translates to:
  /// **'Save Service'**
  String get saveService;

  /// No description provided for @bookingManagement.
  ///
  /// In en, this message translates to:
  /// **'Booking Management'**
  String get bookingManagement;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S SUMMARY'**
  String get todaySummary;

  /// No description provided for @pendingBookings.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingBookings;

  /// No description provided for @homeVisitsCount.
  ///
  /// In en, this message translates to:
  /// **'Home Visits'**
  String get homeVisitsCount;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filterPending;

  /// No description provided for @filterConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get filterConfirmed;

  /// No description provided for @filterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get filterCompleted;

  /// No description provided for @filterRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get filterRejected;

  /// No description provided for @filterCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get filterCancelled;

  /// No description provided for @tagBranchVisit.
  ///
  /// In en, this message translates to:
  /// **'BRANCH VISIT'**
  String get tagBranchVisit;

  /// No description provided for @tagHomeVisit.
  ///
  /// In en, this message translates to:
  /// **'HOME Visit'**
  String get tagHomeVisit;

  /// No description provided for @scanTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan Type'**
  String get scanTypeLabel;

  /// No description provided for @paymentStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT STATUS'**
  String get paymentStatusLabel;

  /// No description provided for @paymentPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paymentPaid;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get paymentPending;

  /// No description provided for @feeLabel.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get feeLabel;

  /// No description provided for @acceptBtn.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptBtn;

  /// No description provided for @rejectBtn.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectBtn;

  /// No description provided for @viewDetailsBtn.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetailsBtn;

  /// No description provided for @phoneNumberAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Phone number already registered'**
  String get phoneNumberAlreadyRegistered;

  /// No description provided for @phoneNumberAvailable.
  ///
  /// In en, this message translates to:
  /// **'Phone number available'**
  String get phoneNumberAvailable;

  /// No description provided for @unsupportedRoleMessage.
  ///
  /// In en, this message translates to:
  /// **'This account type is not supported on this application. Please log in with a healthcare provider account.'**
  String get unsupportedRoleMessage;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeYourMessage;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @tipsForManagingNotifications.
  ///
  /// In en, this message translates to:
  /// **'Tips for managing notifications'**
  String get tipsForManagingNotifications;

  /// No description provided for @keepNotificationsTurnedOn.
  ///
  /// In en, this message translates to:
  /// **'Keep notifications turned on to stay updated on your appointments'**
  String get keepNotificationsTurnedOn;

  /// No description provided for @markCompletedRequestsAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark completed requests as read to keep your inbox organized'**
  String get markCompletedRequestsAsRead;

  /// No description provided for @addTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Add Time Slot'**
  String get addTimeSlot;

  /// No description provided for @financialBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Financial Breakdown'**
  String get financialBreakdown;

  /// No description provided for @totalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Earned'**
  String get totalEarned;

  /// No description provided for @platformFees.
  ///
  /// In en, this message translates to:
  /// **'Platform Fees'**
  String get platformFees;

  /// No description provided for @netRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net Revenue'**
  String get netRevenue;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @grossAmount.
  ///
  /// In en, this message translates to:
  /// **'Gross Amount'**
  String get grossAmount;

  /// No description provided for @feesDeducted.
  ///
  /// In en, this message translates to:
  /// **'Fees Deducted'**
  String get feesDeducted;

  /// No description provided for @fastingRequired.
  ///
  /// In en, this message translates to:
  /// **'Fasting Required'**
  String get fastingRequired;

  /// No description provided for @bloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get bloodGroup;

  /// No description provided for @vacationsAndLeaves.
  ///
  /// In en, this message translates to:
  /// **'Vacations & Leaves'**
  String get vacationsAndLeaves;

  /// No description provided for @addVacation.
  ///
  /// In en, this message translates to:
  /// **'Add Vacation'**
  String get addVacation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
