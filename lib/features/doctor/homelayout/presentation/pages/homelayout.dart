import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/pages/profile_page.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_nav_bar.dart';
import 'home_tab.dart';
import 'appointments_tab.dart';
import 'notifications_tab.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTab(
        onViewAllAppointments: () => _onItemTapped(1),
      ),
      const AppointmentsTab(),
      const NotificationsTab(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      // Using IndexedStack to preserve state of pages
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
