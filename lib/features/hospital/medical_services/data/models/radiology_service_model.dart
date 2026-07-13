class RadiologyServiceModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final bool contrastAgentRequired;
  final String? preparationInstructions;
  final String estimatedDuration;

  RadiologyServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.contrastAgentRequired,
    this.preparationInstructions,
    required this.estimatedDuration,
  });
}
