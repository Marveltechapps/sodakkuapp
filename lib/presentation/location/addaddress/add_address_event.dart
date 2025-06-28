abstract class AddAddressEvent {}

class SaveAddressEvent extends AddAddressEvent {
  final String userId;
  final String label;
  final String houseNo;
  final String building;
  final String landMark;
  final String area;
  final String city;
  final String state;
  final String pinCode;
  final String latitude;
  final String longitude;

  SaveAddressEvent(
      {required this.userId,
      required this.label,
      required this.houseNo,
      required this.building,
      required this.landMark,
      required this.area,
      required this.city,
      required this.state,
      required this.pinCode,
      required this.latitude,
      required this.longitude});
}

class UpdateAddressEvent extends AddAddressEvent {
  final String userId;
  final String id;
  final String label;
  final String houseNo;
  final String building;
  final String landMark;
  final String area;
  final String city;
  final String state;
  final String pinCode;
  final String latitude;
  final String longitude;

  UpdateAddressEvent(
      {required this.userId,
      required this.id,
      required this.label,
      required this.houseNo,
      required this.building,
      required this.landMark,
      required this.area,
      required this.city,
      required this.state,
      required this.pinCode,
      required this.latitude,
      required this.longitude});
}

class SelectLabelEvent extends AddAddressEvent {
  final String label;

  SelectLabelEvent({required this.label});
}
