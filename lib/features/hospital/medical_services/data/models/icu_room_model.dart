class IcuRoomModel {
  final String id;
  final String roomNumber;
  final String bedId;
  final String floorWing;
  final List<String> equipmentList;
  final String status; // 'available', 'occupied', 'cleaning'
  final String? assignedPatient;

  IcuRoomModel({
    required this.id,
    required this.roomNumber,
    required this.bedId,
    required this.floorWing,
    required this.equipmentList,
    required this.status,
    this.assignedPatient,
  });
}
