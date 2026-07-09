import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import '../widgets/marketing/marketing_header.dart';
import '../widgets/marketing/packages_tab_view.dart';
import '../widgets/marketing/my_plan_tab_view.dart';
import '../widgets/marketing/analytics_tab_view.dart';
import '../widgets/marketing/marketing_custom_tab_bar.dart';
import '../../data/mocks/marketing_mock_data.dart';

class MarketingPackagesPage extends StatefulWidget {
  const MarketingPackagesPage({super.key});

  @override
  State<MarketingPackagesPage> createState() => _MarketingPackagesPageState();
}

class _MarketingPackagesPageState extends State<MarketingPackagesPage>
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
      body: NestedScrollView(
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
              packages: MarketingMockData.packages,
              activePlan: MarketingMockData.activePlan,
            ),
            MyPlanTabView(
              packages: MarketingMockData.packages,
              activePlan: MarketingMockData.activePlan,
            ),
            const AnalyticsTabView(),
          ],
        ),
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
