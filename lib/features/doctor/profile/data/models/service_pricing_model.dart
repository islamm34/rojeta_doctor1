class ServicePricingModel {
  final String id;
  final String name; // e.g. "Clinic Visit", "Home Visit"
  final bool isEnabled;
  final double price;
  final String currency;

  const ServicePricingModel({
    required this.id,
    required this.name,
    this.isEnabled = false,
    this.price = 0.0,
    this.currency = 'EGP',
  });

  factory ServicePricingModel.fromJson(Map<String, dynamic> json) {
    return ServicePricingModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isEnabled: json['isEnabled'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'EGP',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isEnabled': isEnabled,
      'price': price,
      'currency': currency,
    };
  }

  ServicePricingModel copyWith({
    String? id,
    String? name,
    bool? isEnabled,
    double? price,
    String? currency,
  }) {
    return ServicePricingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
      price: price ?? this.price,
      currency: currency ?? this.currency,
    );
  }
}
