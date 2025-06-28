import 'package:sodakkuapp/model/settings/get_saved_profile_response_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class UpdateProfileState extends ProfileState {}

class GetSavedProfileState extends ProfileState {
  final GetSavedProfileModel getSavedProfileModel;

  GetSavedProfileState({required this.getSavedProfileModel});
}

class ProfileSaveSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String errorMsg;

  ProfileErrorState({required this.errorMsg});
}
