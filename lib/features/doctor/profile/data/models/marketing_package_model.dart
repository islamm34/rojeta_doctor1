class MarketingPackageModel {
  final String id;
  final String nameKey;
  final String postsPerMonth;
  final int monthlyPrice;
  final int yearlyPrice;
  final bool isMostPopular;
  final List<String> platforms;
  final List<String> features;

  MarketingPackageModel({
    required this.id,
    required this.nameKey,
    required this.postsPerMonth,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.isMostPopular,
    required this.platforms,
    required this.features,
  });
}

class ActivePlanModel {
  final String packageId;
  final int postsUsed;
  final int totalPosts;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> benefits;

  ActivePlanModel({
    required this.packageId,
    required this.postsUsed,
    required this.totalPosts,
    required this.startDate,
    required this.endDate,
    required this.benefits,
  });
}
