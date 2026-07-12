import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
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
      HospitalHomeTab(
        onViewAllAppointments: () => _onItemTapped(1),
      ),
      const Scaffold(body: Center(child: Text("Appointments Placeholder"))),
      const Scaffold(body: Center(child: Text("Depts Placeholder"))),
      const Scaffold(body: Center(child: Text("Settings Placeholder"))),
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
      bottomNavigationBar: HospitalBottomNavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
