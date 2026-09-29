import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:rojeta_doctor/features/booking/presentation/bloc/booking_event.dart';
import 'package:rojeta_doctor/features/booking/presentation/pages/booking_management_page.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/pages/profile_tab.dart';

import '../../../../../core/di/injector.dart';
import '../../../../../features/auth/data/models/user_type_model.dart';
import '../bloc/lab_home_bloc.dart';
import '../bloc/lab_home_event.dart';
import '../widgets/lab_bottom_nav_bar.dart';
import 'lab_home_tab.dart';
import 'lab_tests_tab.dart';

class LabHomeLayoutPage extends StatefulWidget {
  final UserType userType;

  const LabHomeLayoutPage({super.key, required this.userType});

  @override
  State<LabHomeLayoutPage> createState() => _LabHomeLayoutPageState();
}

class _LabHomeLayoutPageState extends State<LabHomeLayoutPage> {
  int _currentIndex = 0;
  late final BookingBloc _bookingBloc;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _bookingBloc = injector<BookingBloc>()
      ..add(FetchBookingsEvent(userType: widget.userType));
    _pages = [
      LabHomeTab(
        userType: widget.userType,
        onViewAllAppointments: () {
          _bookingBloc.add(FetchBookingsEvent(userType: widget.userType));
          _onItemTapped(1);
        },
      ),
      BookingManagementPage(userType: widget.userType, bloc: _bookingBloc),
      LabTestsTab(userType: widget.userType),
      ProfileTab(userType: widget.userType),
    ];
  }

  @override
  void dispose() {
    _bookingBloc.close();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _bookingBloc.add(FetchBookingsEvent(userType: widget.userType));
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<LabHomeBloc>()
            ..add(LoadLabHomeDataEvent(userType: widget.userType)),
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: LabBottomNavBar(
          userType: widget.userType,
          selectedIndex: _currentIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
