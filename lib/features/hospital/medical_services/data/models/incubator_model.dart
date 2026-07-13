class IncubatorModel {
  final String id;
  final String unitId;
  final String model;
  final String wingSection;
  final List<String> monitoringType;
  final String status; // 'ready', 'in_use'
  final double? temperature;
  final int? humidity;

  IncubatorModel({
    required this.id,
    required this.unitId,
    required this.model,
    required this.wingSection,
    required this.monitoringType,
    required this.status,
    this.temperature,
    this.humidity,
  });
}
