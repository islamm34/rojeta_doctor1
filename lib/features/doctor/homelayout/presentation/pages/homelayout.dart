import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/firebase_messaging_service.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/pages/profile_page.dart';
import '../bloc/appointments/doctor_appointments_bloc.dart';
import '../bloc/appointments/doctor_appointments_event.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_nav_bar.dart';
import '../bloc/homelayout_bloc.dart';
import '../bloc/homelayout_event.dart';
import '../bloc/notifications/notifications_cubit.dart';
import '../bloc/notifications/notifications_state.dart';
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
  StreamSubscription<RemoteMessage>? _fcmSubscription;
  DoctorAppointmentsBloc? _appointmentsBloc;
  NotificationsCubit? _notificationsCubit;

  DoctorAppointmentsBloc get appointmentsBloc =>
      _appointmentsBloc ??= injector<DoctorAppointmentsBloc>()
        ..add(const FetchAppointmentsEvent());

  NotificationsCubit get notificationsCubit =>
      _notificationsCubit ??= injector<NotificationsCubit>()
        ..loadNotifications();

  @override
  void reassemble() {
    super.reassemble();
    _appointmentsBloc ??= injector<DoctorAppointmentsBloc>()
      ..add(const FetchAppointmentsEvent());
    _notificationsCubit ??= injector<NotificationsCubit>()..loadNotifications();
  }

  @override
  void initState() {
    super.initState();
    _appointmentsBloc = appointmentsBloc;
    _notificationsCubit = notificationsCubit;

    context.read<HomelayoutBloc>().add(LoadHomelayoutEvent());
    _pages = [
      HomeTab(
        onViewAllAppointments: () => _onItemTapped(1),
        onNotificationTap: () => _onItemTapped(2),
      ),
      const AppointmentsTab(),
      const NotificationsTab(),
      const ProfilePage(),
    ];

    if (injector.isRegistered<FirebaseMessagingService>()) {
      _fcmSubscription = injector<FirebaseMessagingService>()
          .onForegroundMessage
          .listen((message) {
            if (mounted) {
              context.read<HomelayoutBloc>().add(LoadHomelayoutEvent());
              appointmentsBloc.add(const FetchAppointmentsEvent());
              notificationsCubit.loadNotifications();
            }
          });
    }
  }

  @override
  void dispose() {
    _fcmSubscription?.cancel();
    _appointmentsBloc?.close();
    _notificationsCubit?.close();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      context.read<HomelayoutBloc>().add(LoadHomelayoutEvent());
    } else if (index == 1) {
      appointmentsBloc.add(const FetchAppointmentsEvent());
    } else if (index == 2) {
      notificationsCubit.loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: notificationsCubit),
        BlocProvider.value(value: appointmentsBloc),
      ],
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar:
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                return CustomBottomNavBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onItemTapped,
                  badgeCount: state.unreadCount,
                );
              },
            ),
      ),
    );
  }
}
