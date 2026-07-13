class LabTestModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final bool homeCollectionAvailable;
  final String? preparationInstructions;
  final String estimatedResultTime;

  LabTestModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.homeCollectionAvailable,
    this.preparationInstructions,
    required this.estimatedResultTime,
  });
}
