import 'package:flutter/material.dart';
import '../../../../core/utils/screen_util_like.dart';
import 'widgets/home_header.dart';
import 'widgets/stats_section.dart';
import 'widgets/quick_actions.dart';
import 'widgets/upcoming_booking.dart';
import 'widgets/promo_slider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StatsSection(),
                  24.ver,
                  const QuickActions(),
                  24.ver,
                  const UpcomingBooking(),
                  24.ver,
                  const PromoSlider(),
                  20.ver,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
