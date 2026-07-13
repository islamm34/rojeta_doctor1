import 'package:flutter_bloc/flutter_bloc.dart';
import 'nursing_event.dart';
import 'nursing_state.dart';
import '../../data/models/nursing_dashboard_model.dart';
import '../../data/models/nursing_service_model.dart';
import '../../data/models/nursing_staff_model.dart';
import '../../data/models/nursing_profile_model.dart';

class NursingBloc extends Bloc<NursingEvent, NursingState> {
  NursingBloc() : super(const NursingState()) {
    on<ChangeNursingTabEvent>(_onChangeTab);
    on<LoadNursingDashboardData>(_onLoadDashboardData);
    on<LoadNursingServices>(_onLoadServices);
    on<AddNursingServiceEvent>(_onAddService);
    on<LoadNursingStaffEvent>(_onLoadStaff);
    on<AddNursingStaffEvent>(_onAddStaff);
    on<LoadNursingProfileEvent>(_onLoadProfile);
    on<UpdateNursingOfficeInfoEvent>(_onUpdateOfficeInfo);
    on<UpdateNursingWorkingHoursEvent>(_onUpdateWorkingHours);
    on<UpdateNursingSettingsEvent>(_onUpdateSettings);
  }

  void _onChangeTab(ChangeNursingTabEvent event, Emitter<NursingState> emit) {
    emit(state.copyWith(currentTabIndex: event.index));

    // Automatically load data based on the tab selected
    if (event.index == 0 && state.dashboardData == null) {
      add(LoadNursingDashboardData());
    } else if (event.index == 1 && state.services.isEmpty) {
      add(LoadNursingServices());
    } else if (event.index == 2 && state.staff.isEmpty) {
      add(LoadNursingStaffEvent());
    } else if (event.index == 4 && state.profile == null) {
      add(LoadNursingProfileEvent());
    }
  }

  Future<void> _onLoadDashboardData(
    LoadNursingDashboardData event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    // Mocking a network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final mockDashboard = NursingDashboardModel(
      todaysBookings: 8,
      bookingsTrend: '+12% from yesterday',
      activeNurses: 24,
      activeNursesDesc: 'On-duty across all wards',
      totalEarnings: 12450.0,
      earningsDesc: 'Monthly revenue to date',
      upcomingBookings: [
        const NursingBookingModel(
          dateMonth: 'MAY',
          dateDay: '2',
          patientName: 'Eleanor Thompson',
          serviceType: '24-Hour Nursing Care',
          time: '08:00 AM',
        ),
        const NursingBookingModel(
          dateMonth: 'MAY',
          dateDay: '2',
          patientName: 'Marcus Rodriguez',
          serviceType: 'Post-Operative Support',
          time: '11:30 AM',
        ),
        const NursingBookingModel(
          dateMonth: 'MAY',
          dateDay: '3',
          patientName: 'Sarah Jenkins',
          serviceType: 'Elderly Care Routine',
          time: '09:00 AM',
        ),
      ],
    );

    emit(state.copyWith(
      status: NursingStatus.success,
      dashboardData: mockDashboard,
    ));
  }

  Future<void> _onLoadServices(
    LoadNursingServices event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    // Mocking network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final mockServices = [
      const NursingServiceModel(
        title: '12-Hour Nursing',
        subtitle: 'Professional nursing care for 12 hours',
        durationTag: '12 Hours',
        bulletPoints: [
          'Day or Night shift',
          'Vital signs monitoring',
          'Medication management',
          'Basic medical care'
        ],
        // iconColorCode: 0xFF3B82F6, // Blue
        // iconCodePoint: 0xe03a, // Icons.access_time
      ),
      const NursingServiceModel(
        title: '24-Hour Nursing',
        subtitle: 'Round-the-clock nursing care',
        durationTag: '24 Hours',
        bulletPoints: [
          '24/7 coverage',
          'Complete patient care',
          'Emergency response',
          'Family support'
        ],
        // iconColorCode: 0xFFEC4899, // Pink
        // iconCodePoint: 0xe25c, // Icons.favorite_border
      ),
      const NursingServiceModel(
        title: 'Medication Administration',
        subtitle: 'Injection & medication services',
        durationTag: 'Per Visit',
        bulletPoints: [
          'IM/IV injections',
          'Insulin administration',
          'Wound dressing',
          'Home visits'
        ],
        // iconColorCode: 0xFF10B981, // Green
        // iconCodePoint: 0xf028c, // Icons.vaccines
      ),
      const NursingServiceModel(
        title: 'Newborn Baby Care',
        subtitle: 'Specialized newborn nursing',
        durationTag: 'Flexible',
        bulletPoints: [
          'Feeding assistance',
          'Bathing & hygiene',
          'Health monitoring',
          'Mother support'
        ],
        // iconColorCode: 0xFFA855F7, // Purple
        // iconCodePoint: 0xf05a1, // Icons.child_friendly
      ),
      const NursingServiceModel(
        title: 'Elderly Care',
        subtitle: 'Comprehensive elderly nursing',
        durationTag: 'Flexible',
        bulletPoints: [
          'Daily living assistance',
          'Medication reminders',
          'Companionship',
          'Health monitoring'
        ],
        // iconColorCode: 0xFF059669, // Dark Green
        // iconCodePoint: 0xe491, // Icons.person_outline
      ),
    ];

    emit(state.copyWith(
      status: NursingStatus.success,
      services: mockServices,
    ));
  }

  Future<void> _onAddService(
    AddNursingServiceEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    await Future.delayed(const Duration(milliseconds: 600));

    final updatedServices = List<NursingServiceModel>.from(state.services)..insert(0, event.service);

    emit(state.copyWith(
      status: NursingStatus.success,
      services: updatedServices,
    ));
  }

  Future<void> _onLoadStaff(
    LoadNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    await Future.delayed(const Duration(milliseconds: 600));

    final mockStats = NursingStaffStatsModel(
      totalStaff: 24,
      available: 18,
      onDuty: 6,
      onLeave: 2,
    );

    final mockStaff = [
      NursingStaffModel(
        id: '1',
        name: 'Sarah Mohamed',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
        gender: 'FEMALE',
        status: 'AVAILABLE',
        skills: ['ICU', 'Pediatrics'],
        yearsOfExperience: 8,
      ),
      NursingStaffModel(
        id: '2',
        name: 'Mark john',
        imageUrl: 'https://i.pravatar.cc/150?img=11',
        gender: 'MALE',
        status: 'BUSY',
        skills: ['Geriatrics', 'Wound Care'],
        yearsOfExperience: 12,
      ),
      NursingStaffModel(
        id: '3',
        name: 'Eman Ahmed',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        gender: 'FEMALE',
        status: 'AVAILABLE',
        skills: ['Post-Op', 'IV Therapy'],
        yearsOfExperience: 5,
      ),
    ];

    emit(state.copyWith(
      status: NursingStatus.success,
      staff: mockStaff,
      staffStats: mockStats,
    ));
  }

  Future<void> _onAddStaff(
    AddNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    await Future.delayed(const Duration(milliseconds: 600));

    final updatedStaff = List<NursingStaffModel>.from(state.staff)..insert(0, event.staff);
    final updatedStats = NursingStaffStatsModel(
      totalStaff: (state.staffStats?.totalStaff ?? 0) + 1,
      available: (state.staffStats?.available ?? 0) + 1,
      onDuty: state.staffStats?.onDuty ?? 0,
      onLeave: state.staffStats?.onLeave ?? 0,
    );

    emit(state.copyWith(
      status: NursingStatus.success,
      staff: updatedStaff,
      staffStats: updatedStats,
    ));
  }

  Future<void> _onLoadProfile(
    LoadNursingProfileEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    await Future.delayed(const Duration(milliseconds: 600));

    const mockProfile = NursingProfileModel(
      id: '1',
      name: 'Graceful Care Nursing',
      licenseNumber: 'LAB-2023-994821',
      avatarUrl: 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200&h=200&fit=crop',
      servicesCount: 8,
      nursesCount: 45,
    );

    const mockOfficeInfo = NursingOfficeInfoModel(
      officeName: 'City Lab',
      licenseNumber: 'CLIA-882944-B',
      email: 'admin@centraldiag.com',
      phone: '+1 (555) 012-3456',
      description: 'Founded in 2005, Central provides state-of-the-art diagnostic services focusing on hematology, microbiology',
      verificationStatus: 'ACTIVE STATUS',
    );

    const mockSettings = NursingSettingsModel(
      emailNotifications: true,
      bookingUpdates: true,
      pushNotifications: true,
      appointmentReminders: true,
      marketingEmails: false,
      language: '',
    );

    const mockWorkingHours = NursingWorkingHoursModel(
      days: [
        DailyWorkingHoursModel(day: 'Monday', isOpen: true, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Tuesday', isOpen: true, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Wednesday', isOpen: true, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Thursday', isOpen: true, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Friday', isOpen: true, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Saturday', isOpen: false, openTime: '08:00 AM', closeTime: '06:00 PM'),
        DailyWorkingHoursModel(day: 'Sunday', isOpen: false, openTime: '08:00 AM', closeTime: '06:00 PM'),
      ],
    );

    emit(state.copyWith(
      status: NursingStatus.success,
      profile: mockProfile,
      officeInfo: mockOfficeInfo,
      workingHours: mockWorkingHours,
      settings: mockSettings,
    ));
  }

  void _onUpdateOfficeInfo(UpdateNursingOfficeInfoEvent event, Emitter<NursingState> emit) {
    emit(state.copyWith(officeInfo: event.officeInfo));
  }

  void _onUpdateWorkingHours(UpdateNursingWorkingHoursEvent event, Emitter<NursingState> emit) {
    emit(state.copyWith(workingHours: event.workingHours));
  }

  void _onUpdateSettings(UpdateNursingSettingsEvent event, Emitter<NursingState> emit) {
    emit(state.copyWith(settings: event.settings));
  }
}
