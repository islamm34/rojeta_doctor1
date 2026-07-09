import 'package:rojeta_doctor/features/doctor/profile/data/models/marketing_package_model.dart';


class MarketingMockData {
  static List<MarketingPackageModel> get packages => [
        MarketingPackageModel(
          id: 'basic',
          nameKey: 'basic',
          postsPerMonth: '8',
          monthlyPrice: 3500,
          yearlyPrice: 35000,
          isMostPopular: false,
          platforms: ['Facebook', 'Instagram'],
          features: [
            'designQuality',
            'support',
          ],
        ),
        MarketingPackageModel(
          id: 'professional',
          nameKey: 'professional',
          postsPerMonth: '12',
          monthlyPrice: 5000,
          yearlyPrice: 50000,
          isMostPopular: true,
          platforms: ['Facebook', 'Instagram', 'Twitter'],
          features: [
            'designQuality',
            'analytics',
            'priority',
            'support',
          ],
        ),
        MarketingPackageModel(
          id: 'premium',
          nameKey: 'premium',
          postsPerMonth: '20',
          monthlyPrice: 8000,
          yearlyPrice: 80000,
          isMostPopular: false,
          platforms: ['Facebook', 'Instagram', 'Twitter'],
          features: [
            'designQuality',
            'analytics',
            'priority',
            'support',
          ],
        ),
      ];

  static ActivePlanModel get activePlan => ActivePlanModel(
        packageId: 'professional',
        postsUsed: 8,
        totalPosts: 12,
        startDate: DateTime.now().subtract(const Duration(days: 15)),
        endDate: DateTime.now().add(const Duration(days: 15)),
        benefits: [
          'benefit1',
          'benefit2',
          'benefit3',
          'benefit4',
          'benefit5',
        ],
      );
}
