import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import '../bloc/marketing/marketing_bloc.dart';
import '../bloc/marketing/marketing_event.dart';
import '../bloc/marketing/marketing_state.dart';
import '../widgets/marketing/marketing_header.dart';
import '../widgets/marketing/packages_tab_view.dart';
import '../widgets/marketing/my_plan_tab_view.dart';
import '../widgets/marketing/analytics_tab_view.dart';
import '../widgets/marketing/marketing_custom_tab_bar.dart';

class MarketingPackagesPage extends StatelessWidget {
  const MarketingPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injector<MarketingBloc>()..add(const FetchMarketingDataEvent()),
      child: const _MarketingPackagesContent(),
    );
  }
}

class _MarketingPackagesContent extends StatefulWidget {
  const _MarketingPackagesContent();

  @override
  State<_MarketingPackagesContent> createState() =>
      _MarketingPackagesContentState();
}

class _MarketingPackagesContentState extends State<_MarketingPackagesContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.offerGradientEnd,
                AppColors.offerGradientStart,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          context.strings.socialMediaMarketing,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<MarketingBloc, MarketingState>(
        builder: (context, state) {
          if (state.status == MarketingStatus.loading &&
              state.packages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(child: MarketingHeader()),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    MarketingCustomTabBar(
                      controller: _tabController,
                      labels: [
                        context.strings.packages,
                        context.strings.myPlan,
                        context.strings.analytics,
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                PackagesTabView(
                  packages: state.packages,
                  activePlan: state.activePlan,
                  onSubscribe: (packageId, cycle) {
                    context.read<MarketingBloc>().add(
                          SubscribeToPackageEvent(
                            packageId: packageId,
                            billingCycle: cycle,
                          ),
                        );
                  },
                ),
                MyPlanTabView(
                  packages: state.packages,
                  activePlan: state.activePlan,
                ),
                AnalyticsTabView(analytics: state.analytics),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final MarketingCustomTabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}
