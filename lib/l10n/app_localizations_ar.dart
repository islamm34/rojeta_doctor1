// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحباً';

  @override
  String get chooseTypeTitle => 'اختر نوع المستخدم';

  @override
  String get chooseTypeSubtitle => 'يرجى تحديد كيفية استخدام التطبيق';

  @override
  String get doctor => 'طبيب';

  @override
  String get doctorDesc =>
      'سجل كممارس طبي لإدارة الحجوزات والعيادات واستشارة المرضى.';

  @override
  String get patient => 'مريض / مستخدم';

  @override
  String get patientDesc =>
      'سجل كمريض لطلب الاستشارة، حجز المواعيد والتحدث مع الأطباء.';

  @override
  String get continueButton => 'متابعة';

  @override
  String get loginTitle => 'مرحباً بعودتك';

  @override
  String get loginSubtitle => 'قم بتسجيل الدخول للوصول إلى حسابك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get registerNow => 'سجل الآن';

  @override
  String get signUpTitle => 'إنشاء حساب';

  @override
  String get signUpSubtitle => 'املأ البيانات للبدء';

  @override
  String get specialization => 'التخصص';

  @override
  String get clinicAddress => 'عنوان العيادة';

  @override
  String get syndicateNumber => 'رقم ترخيص المزاولة / النقابة';

  @override
  String get bio => 'نبذة تعريفية قصيرة';

  @override
  String get registerButton => 'تسجيل';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get otpVerificationTitle => 'التحقق';

  @override
  String get otpVerificationSubtitle =>
      'أدخل الرمز المكون من 4 أرقام المرسل إلى جهازك';

  @override
  String get verifyButton => 'التحقق من الرمز';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get invalidPassword => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get welcomeBackUser => 'مرحباً، سيتي لابل';

  @override
  String get whatsHappeningToday => 'إليك ما يحدث اليوم.';

  @override
  String get todaysBookings => 'حجوزات اليوم';

  @override
  String get since8am => '+2 منذ الساعة 8 صباحاً';

  @override
  String get pendingRequests => 'طلبات معلقة';

  @override
  String get homeVisits => 'زيارات منزلية';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get addTest => 'إضافة اختبار';

  @override
  String get manageBranch => 'إدارة الفرع';

  @override
  String get viewBookings => 'عرض الحجوزات';

  @override
  String get upcomingBooking => 'الحجز القادم';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get save30 => 'وفر 30%';

  @override
  String get upgradeToPremium => 'الترقية للمميز';

  @override
  String get upgradeDesc => 'احصل على تحليلات متقدمة وحجوزات غير محدودة';

  @override
  String get upgradeNow => 'الترقية الآن';
}
