import 'package:equatable/equatable.dart';

class PharmaAdBannerModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? badge;
  final String? imageUrl;
  final String? actionUrl;
  final String? buttonText;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final List<String>? gradientHexColors;

  const PharmaAdBannerModel({
    required this.id,
    required this.title,
    required this.description,
    this.badge,
    this.imageUrl,
    this.actionUrl,
    this.buttonText,
    this.startDate,
    this.endDate,
    this.isActive = true,
    this.gradientHexColors,
  });

  /// Checks if the ad is currently within its active validity period
  bool get isCurrentlyActive {
    if (!isActive) return false;
    final now = DateTime.now();
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    return true;
  }

  /// Calculates remaining active days
  int get remainingDays {
    if (endDate == null) return -1;
    final diff = endDate!.difference(DateTime.now()).inDays;
    return diff > 0 ? diff : 0;
  }

  factory PharmaAdBannerModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      try {
        return DateTime.parse(value.toString());
      } catch (_) {
        return null;
      }
    }

    // Support duration in days if endDate is not explicitly set
    DateTime? resolvedEndDate = parseDate(json['endDate'] ?? json['end_date']);
    final durationDays = json['durationDays'] ?? json['duration_days'] ?? json['days'];
    if (resolvedEndDate == null && durationDays != null) {
      final days = int.tryParse(durationDays.toString()) ?? 0;
      final start = parseDate(json['startDate'] ?? json['start_date']) ?? DateTime.now();
      resolvedEndDate = start.add(Duration(days: days));
    }

    return PharmaAdBannerModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      description: (json['description'] ?? json['subtitle'] ?? json['desc'] ?? '').toString(),
      badge: (json['badge'] ?? json['tag'] ?? json['offerBadge'])?.toString(),
      imageUrl: (json['imageUrl'] ?? json['image_url'] ?? json['image'] ?? json['banner_url'])?.toString(),
      actionUrl: (json['actionUrl'] ?? json['action_url'] ?? json['link'] ?? json['url'] ?? json['website'])?.toString(),
      buttonText: (json['buttonText'] ?? json['button_text'] ?? json['btn_text'] ?? json['cta'])?.toString(),
      startDate: parseDate(json['startDate'] ?? json['start_date']),
      endDate: resolvedEndDate,
      isActive: json['isActive'] ?? json['is_active'] ?? json['status'] == 'active' ?? true,
      gradientHexColors: (json['gradientColors'] ?? json['gradient_colors'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'badge': badge,
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
      'buttonText': buttonText,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'gradientColors': gradientHexColors,
    };
  }

  /// Default banners including Pharma ads and Rojeta Pro offer
  static List<PharmaAdBannerModel> get defaultBanners => [
        PharmaAdBannerModel(
          id: 'banner_1',
          title: 'Upgrade to Premium',
          description: 'Get advanced analytics and unlimited appointments',
          badge: 'Save 30%',
          actionUrl: 'internal://marketing_packages',
          buttonText: 'Upgrade Now',
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now().add(const Duration(days: 30)),
          isActive: true,
          gradientHexColors: const ['#A855F7', '#EC4899'],
        ),
        PharmaAdBannerModel(
          id: 'banner_2',
          title: 'Eva Pharma | إيفا فارما',
          description: 'أحدث بروتوكولات الأدوية القلبية ومضادات التخثر المعتمدة',
          badge: 'راعي طبي ⭐',
          actionUrl: 'https://www.evapharma.com',
          buttonText: 'زيارة الموقع الرسمي',
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now().add(const Duration(days: 14)), // 14 days campaign
          isActive: true,
          gradientHexColors: const ['#0284C7', '#2563EB'],
        ),
        PharmaAdBannerModel(
          id: 'banner_3',
          title: 'AstraZeneca | أسترازينيكا',
          description: 'دليل الأدوية البيولوجية وأبحاث الجهاز التنفسي 2026',
          badge: 'مؤتمر دوائي',
          actionUrl: 'https://www.astrazeneca.com',
          buttonText: 'عرض التفاصيل والجرعات',
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now().add(const Duration(days: 7)), // 7 days campaign
          isActive: true,
          gradientHexColors: const ['#0D9488', '#059669'],
        ),
      ];

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        badge,
        imageUrl,
        actionUrl,
        buttonText,
        startDate,
        endDate,
        isActive,
        gradientHexColors,
      ];
}

