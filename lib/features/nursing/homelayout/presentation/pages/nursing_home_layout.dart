import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import 'package:rojeta_doctor/features/booking/presentation/pages/booking_management_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../bloc/nursing_bloc.dart';
import '../bloc/nursing_event.dart';
import '../bloc/nursing_state.dart';
import 'tabs/nursing_home_tab.dart';
import 'tabs/nursing_services_tab.dart';
import 'tabs/nursing_staff_tab.dart';
import 'tabs/nursing_profile_tab.dart';

class NursingHomeLayout extends StatelessWidget {
  const NursingHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NursingBloc()..add(LoadNursingDashboardData()),
      child: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentTabIndex,
              children: [
                const NursingHomeTab(),
                const NursingServicesTab(),
                const NursingStaffTab(),
                const BookingManagementPage(userType: UserType.nursingCareProviders),
                const NursingProfileTab(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentTabIndex,
              onTap: (index) {
                context.read<NursingBloc>().add(ChangeNursingTabEvent(index));
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFF1877F2),
              unselectedItemColor: const Color(0xFF64748B),
              showUnselectedLabels: true,
              selectedLabelStyle: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelStyle: context.textTheme.labelSmall,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services_outlined),
                  activeIcon: Icon(Icons.medical_services),
                  label: 'Services',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  activeIcon: Icon(Icons.people),
                  label: 'Nurses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
