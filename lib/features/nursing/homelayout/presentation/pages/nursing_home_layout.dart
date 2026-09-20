import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../../../booking/presentation/pages/booking_management_page.dart';
import '../bloc/nursing_bloc.dart';
import '../bloc/nursing_event.dart';
import '../bloc/nursing_state.dart';
import 'tabs/nursing_home_tab.dart';
import 'tabs/nursing_profile_tab.dart';
import 'tabs/nursing_services_tab.dart';
import 'tabs/nursing_staff_tab.dart';

class NursingHomeLayout extends StatelessWidget {
  const NursingHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<NursingBloc>()..add(LoadNursingDashboardData()),
      child: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          final strings = context.strings;
          return Scaffold(
            body: IndexedStack(
              index: state.currentTabIndex,
              children: const [
                NursingHomeTab(),
                NursingServicesTab(),
                NursingStaffTab(),
                BookingManagementPage(userType: UserType.nursingCareProviders),
                NursingProfileTab(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentTabIndex,
              onTap: (index) {
                context.read<NursingBloc>().add(ChangeNursingTabEvent(index));
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.headerGradientStart,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              selectedLabelStyle: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: context.textTheme.labelSmall,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.dashboard_outlined),
                  activeIcon: const Icon(Icons.dashboard),
                  label: strings.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.medical_services_outlined),
                  activeIcon: const Icon(Icons.medical_services),
                  label: strings.services,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.people_outline),
                  activeIcon: const Icon(Icons.people),
                  label: strings.nurses,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_today_outlined),
                  activeIcon: const Icon(Icons.calendar_today),
                  label: strings.bookings,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  activeIcon: const Icon(Icons.person),
                  label: strings.profile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
