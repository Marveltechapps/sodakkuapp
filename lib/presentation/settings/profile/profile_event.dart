abstract class ProfileEvent {}

class GetSavedProfileDataEvent extends ProfileEvent {
  final String userId;

  GetSavedProfileDataEvent({required this.userId});
}

class SaveProfileApiEvent extends ProfileEvent {
  final String name;
  final String mobileNo;
  final String emailAddress;

  SaveProfileApiEvent(
      {required this.name, required this.mobileNo, required this.emailAddress});
}

class UpdateProfileApiEvent extends ProfileEvent {
  final String name;
  final String mobileNo;
  final String emailAddress;

  UpdateProfileApiEvent(
      {required this.name, required this.mobileNo, required this.emailAddress});
}
