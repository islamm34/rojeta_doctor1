import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/pages/appointments_tab.dart';
import 'package:rojeta_doctor/features/hospital/medical_services/presentation/bloc/medical_services_bloc.dart';
import 'package:rojeta_doctor/features/hospital/medical_services/presentation/pages/medical_services_tab.dart';
import 'package:rojeta_doctor/features/hospital/settings/presentation/pages/settings_page.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../bloc/hospital_bloc.dart';
import '../bloc/hospital_event.dart';
import '../widgets/hospital_bottom_nav_bar.dart';
import 'hospital_home_tab.dart';

class HospitalHomeLayoutPage extends StatefulWidget {
  const HospitalHomeLayoutPage({super.key});

  @override
  State<HospitalHomeLayoutPage> createState() => _HospitalHomeLayoutPageState();
}

class _HospitalHomeLayoutPageState extends State<HospitalHomeLayoutPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HospitalHomeTab(onViewAllAppointments: () => _onItemTapped(1)),
      const AppointmentsTab(),
      BlocProvider.value(
        value: injector<MedicalServicesBloc>(),
        child: const MedicalServicesTab(),
      ),
      const SettingsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injector<HospitalBloc>()..add(const LoadHospitalDashboardEvent()),
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        // Using IndexedStack to preserve state of pages
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: HospitalBottomNavBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
