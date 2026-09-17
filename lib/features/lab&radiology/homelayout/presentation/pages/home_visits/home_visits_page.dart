import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/presentation/bloc/home_visits/home_visits_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/presentation/bloc/home_visits/home_visits_event.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/presentation/bloc/home_visits/home_visits_state.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import 'widgets/available_time_slots_card.dart';
import 'widgets/fee_input_card.dart';
import 'widgets/service_areas_card.dart';
import 'widgets/service_status_card.dart';

class HomeVisitsPage extends StatelessWidget {
  final UserType userType;

  const HomeVisitsPage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<HomeVisitsBloc>()
            ..add(LoadHomeVisitsConfig(userType: userType)),
      child: const HomeVisitsView(),
    );
  }
}

class HomeVisitsView extends StatelessWidget {
  const HomeVisitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Home Visits',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
      ),
      body: BlocConsumer<HomeVisitsBloc, HomeVisitsState>(
        listener: (context, state) {
          if (state.status == HomeVisitsStatus.saveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings saved successfully!')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == HomeVisitsStatus.initial ||
              state.status == HomeVisitsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final config = state.config;
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 20.h,
                  bottom: 100.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Configure how your laboratory manages diagnostic sample pickups from patient residences.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF475569),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ServiceStatusCard(
                      isVisible: config.isServiceVisible ?? false,
                      onToggle: (val) {
                        context.read<HomeVisitsBloc>().add(
                          ToggleServiceStatus(),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    ServiceAreasCard(
                      areas: config.serviceAreas ?? const [],
                      onAddArea: () {
                        // ponytail: navigate to add area page
                      },
                      onDeleteArea: (id) {
                        // ponytail: handle area deletion
                      },
                    ),
                    SizedBox(height: 16.h),
                    FeeInputCard(
                      title: 'Collection Fee',
                      subtext:
                          'Flat rate applied to all residential visits regardless of test volume.',
                      value: config.collectionFee ?? 0.0,
                      icon: Icons.money,
                      onChanged: (val) {
                        context.read<HomeVisitsBloc>().add(
                          UpdateCollectionFee(val),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    FeeInputCard(
                      title: 'Minimum Booking Amount',
                      subtext:
                          'Service will only be available if subtotal exceeds this amount.',
                      value: config.minimumBookingAmount ?? 0.0,
                      icon: Icons.shopping_bag_outlined,
                      onChanged: (val) {
                        context.read<HomeVisitsBloc>().add(
                          UpdateMinimumBooking(val),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    AvailableTimeSlotsCard(
                      slots: (config.isWeekdaysTabActive ?? true)
                          ? (config.weekdaySlots ?? const [])
                          : (config.weekendSlots ?? const []),
                      isWeekdaysTabActive: config.isWeekdaysTabActive ?? true,
                      onTabChanged: (isWeekdays) {
                        context.read<HomeVisitsBloc>().add(
                          ToggleWeekdaysTab(isWeekdays: isWeekdays),
                        );
                      },
                      onAddSlot: () {
                        // ponytail: implement add slot
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            backgroundColor: const Color(0xFFFEF2F2),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Discard Changes',
                            style: TextStyle(
                              color: const Color(0xFF7A8FA6),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.status == HomeVisitsStatus.saving
                              ? null
                              : () {
                                  context.read<HomeVisitsBloc>().add(
                                    SaveHomeVisitsConfig(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFFFC5600,
                            ), // Orange save button
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: state.status == HomeVisitsStatus.saving
                              ? SizedBox(
                                  width: 20.r,
                                  height: 20.r,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Save Settings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
