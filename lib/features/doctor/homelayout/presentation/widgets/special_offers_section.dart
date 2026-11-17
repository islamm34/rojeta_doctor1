import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/pharma_ad_banner_model.dart';

class SpecialOffersSection extends StatefulWidget {
  final VoidCallback? onUpgradeTap;
  final List<PharmaAdBannerModel>? customBanners;

  const SpecialOffersSection({
    super.key,
    this.onUpgradeTap,
    this.customBanners,
  });

  @override
  State<SpecialOffersSection> createState() => _SpecialOffersSectionState();
}

class _SpecialOffersSectionState extends State<SpecialOffersSection> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;
  late List<PharmaAdBannerModel> _activeBanners;

  @override
  void initState() {
    super.initState();
    _initBanners();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant SpecialOffersSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.customBanners != oldWidget.customBanners) {
      _initBanners();
      _startAutoScroll();
    }
  }

  void _initBanners() {
    final source = widget.customBanners?.isNotEmpty == true
        ? widget.customBanners!
        : PharmaAdBannerModel.defaultBanners;

    // Filter out ads that have expired based on their start/end dates
    _activeBanners = source.where((b) => b.isCurrentlyActive).toList();

    // Fallback if all are filtered out
    if (_activeBanners.isEmpty && source.isNotEmpty) {
      _activeBanners = [source.first];
    }
    if (_currentPage >= _activeBanners.length) {
      _currentPage = 0;
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_activeBanners.length <= 1) return;

    // Auto-scroll every 3 seconds to the right (next banner)
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !_pageController.hasClients) return;
      final nextPage = (_currentPage + 1) % _activeBanners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleAdTap(PharmaAdBannerModel banner) async {
    final url = banner.actionUrl?.trim();
    if (url != null && (url.startsWith('http://') || url.startsWith('https://'))) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        try {
          final launched = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          if (!launched && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تعذر فتح الرابط')),
            );
          }
        } catch (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تعذر فتح الرابط')),
            );
          }
        }
        return;
      }
    }

    // Default action for internal offers (e.g., Upgrade to Pro)
    widget.onUpgradeTap?.call();
  }

  Color _parseHex(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) return fallback;
    try {
      final clean = hex.replaceAll('#', '').trim();
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_activeBanners.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with Gift Icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.strings.specialOffers,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18.sp,
              ),
            ),
            Icon(
              Icons.card_giftcard,
              color: Colors.pink,
              size: 24.sp,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Special Offer Carousel
        SizedBox(
          height: 255.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _activeBanners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _activeBanners[index];
              final gradientColors = banner.gradientHexColors != null &&
                      banner.gradientHexColors!.length >= 2
                  ? [
                      _parseHex(
                        banner.gradientHexColors![0],
                        AppColors.offerGradientStart,
                      ),
                      _parseHex(
                        banner.gradientHexColors![1],
                        AppColors.offerGradientEnd,
                      ),
                    ]
                  : const [
                      AppColors.offerGradientStart,
                      AppColors.offerGradientEnd,
                    ];

              final isPharmaAd = banner.actionUrl != null &&
                  banner.actionUrl!.startsWith('http');
              final isRtl = Directionality.of(context) == TextDirection.rtl;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors.first.withValues(alpha: 0.35),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Badge (e.g. Save 30%, إعلان رعاية, remaining days)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPharmaAd ? Icons.verified : Icons.flash_on,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                banner.badge ??
                                    (isPharmaAd ? 'إعلان رعاية' : context.strings.save30),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (banner.endDate != null && banner.remainingDays >= 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text(
                              isRtl
                                  ? 'متبقي ${banner.remainingDays} يوم'
                                  : '${banner.remainingDays} days left',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    // Main content: Icon & Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54.w,
                          height: 54.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: banner.imageUrl != null &&
                                    banner.imageUrl!.startsWith('http')
                                ? Image.network(
                                    banner.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Icon(
                                      isPharmaAd
                                          ? Icons.medication_outlined
                                          : Icons.workspace_premium_outlined,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                  )
                                : Icon(
                                    isPharmaAd
                                        ? Icons.medication_outlined
                                        : Icons.workspace_premium_outlined,
                                    color: Colors.white,
                                    size: 28.sp,
                                  ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner.title,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                banner.description,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.92),
                                  fontSize: 12.sp,
                                  height: 1.35,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // CTA Button: Launches URL or opens upgrade
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2C1A4D),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        onPressed: () => _handleAdTap(banner),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              banner.buttonText ??
                                  (isPharmaAd
                                      ? (isRtl ? 'زيارة الموقع' : 'Visit Website')
                                      : context.strings.upgradeNow),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              isPharmaAd
                                  ? Icons.open_in_new
                                  : (isRtl ? Icons.arrow_back : Icons.arrow_forward),
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 14.h),
        // Dynamic Page Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_activeBanners.length, (index) {
            final isSelected = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: isSelected ? 24.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.offerGradientStart
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}
