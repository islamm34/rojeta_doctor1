import 'package:equatable/equatable.dart';

class MarketingPackageModel extends Equatable {
  final String id;
  final String nameKey;
  final String postsPerMonth;
  final double monthlyPrice;
  final double yearlyPrice;
  final bool isMostPopular;
  final List<String> platforms;
  final List<String> features;

  const MarketingPackageModel({
    required this.id,
    required this.nameKey,
    required this.postsPerMonth,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.isMostPopular,
    required this.platforms,
    required this.features,
  });

  factory MarketingPackageModel.fromJson(Map<String, dynamic> json) {
    return MarketingPackageModel(
      id: json['id']?.toString() ?? '',
      nameKey: json['nameKey'] as String? ?? '',
      postsPerMonth: json['postsPerMonth']?.toString() ?? '',
      monthlyPrice: (json['monthlyPrice'] as num?)?.toDouble() ?? 0.0,
      yearlyPrice: (json['yearlyPrice'] as num?)?.toDouble() ?? 0.0,
      isMostPopular: json['isMostPopular'] as bool? ?? false,
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameKey': nameKey,
      'postsPerMonth': postsPerMonth,
      'monthlyPrice': monthlyPrice,
      'yearlyPrice': yearlyPrice,
      'isMostPopular': isMostPopular,
      'platforms': platforms,
      'features': features,
    };
  }

  @override
  List<Object?> get props => [
        id,
        nameKey,
        postsPerMonth,
        monthlyPrice,
        yearlyPrice,
        isMostPopular,
        platforms,
        features,
      ];
}

class ActivePlanModel extends Equatable {
  final String packageId;
  final int postsUsed;
  final int totalPosts;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> benefits;

  const ActivePlanModel({
    required this.packageId,
    required this.postsUsed,
    required this.totalPosts,
    required this.startDate,
    required this.endDate,
    this.benefits = const [],
  });

  factory ActivePlanModel.fromJson(Map<String, dynamic> json) {
    return ActivePlanModel(
      packageId: json['packageId']?.toString() ?? '',
      postsUsed: (json['postsUsed'] as num?)?.toInt() ?? 0,
      totalPosts: (json['totalPosts'] as num?)?.toInt() ?? 0,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      benefits: (json['benefits'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageId': packageId,
      'postsUsed': postsUsed,
      'totalPosts': totalPosts,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'benefits': benefits,
    };
  }

  @override
  List<Object?> get props => [
        packageId,
        postsUsed,
        totalPosts,
        startDate,
        endDate,
        benefits,
      ];
}
