import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/shared/widgets/error_display_widget.dart';
import 'package:rojeta_doctor/shared/widgets/loading_widget.dart';

import '../../../../features/auth/data/models/user_type_model.dart';
import '../../data/models/booking_model.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import '../widgets/booking_details_bottom_sheet.dart';
import '../widgets/booking_filter_chips.dart';
import '../widgets/booking_item_card.dart';
import '../widgets/booking_summary_card.dart';

class BookingManagementPage extends StatelessWidget {
  final UserType userType;

  const BookingManagementPage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<BookingBloc>()..add(FetchBookingsEvent(userType: userType)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.strings.bookingManagement,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.status == BookingStateStatus.loading) {
              return const Center(child: LoadingWidget());
            }

            if (state.status == BookingStateStatus.failure) {
              return ErrorDisplayWidget(
                message: state.errorMessage ?? 'An error occurred',
                onRetry: () => context.read<BookingBloc>().add(
                  FetchBookingsEvent(userType: userType),
                ),
              );
            }

            final pendingCount = state.allBookings
                .where((b) => b.status == BookingStatus.pending)
                .length;
            final homeVisitsCount = state.allBookings
                .where((b) => b.type == BookingType.homeVisit)
                .length;

            return RefreshIndicator(
              onRefresh: () async => context.read<BookingBloc>().add(
                FetchBookingsEvent(userType: userType),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookingSummaryCard(
                      pendingCount: pendingCount,
                      homeVisitsCount: homeVisitsCount,
                    ),
                    SizedBox(height: 24.h),
                    BookingFilterChips(
                      currentFilter: state.currentFilter,
                      onFilterChanged: (filter) => context
                          .read<BookingBloc>()
                          .add(ChangeFilterEvent(newFilter: filter)),
                    ),
                    SizedBox(height: 24.h),
                    if (state.filteredBookings.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Text(
                            context.strings.noBookingsFound,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.filteredBookings.length,
                        itemBuilder: (context, index) {
                          final booking = state.filteredBookings[index];
                          return BookingItemCard(
                            booking: booking,
                            userType: userType,
                            onAccept: () => context.read<BookingBloc>().add(
                              AcceptBookingEvent(bookingId: booking.id ?? ''),
                            ),
                            onReject: () => context.read<BookingBloc>().add(
                              RejectBookingEvent(bookingId: booking.id ?? ''),
                            ),
                            onViewDetails: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BookingDetailsBottomSheet(
                                  booking: booking,
                                  userType: userType,
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
