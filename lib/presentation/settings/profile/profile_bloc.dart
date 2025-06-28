import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/settings/get_saved_profile_response_model.dart';
import 'package:sodakkuapp/model/settings/profile_error_model.dart';
import 'package:sodakkuapp/model/settings/profile_save_request_model.dart';
import 'package:sodakkuapp/model/settings/save_profile_error_model.dart';
import 'package:sodakkuapp/model/settings/update_profile_response_model.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_event.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_state.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;
import 'package:sodakkuapp/utils/constant.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<SaveProfileApiEvent>(onSaveProfie);
    on<GetSavedProfileDataEvent>(getSavedProfile);
    on<UpdateProfileApiEvent>(onUpdateProfie);
  }

  getSavedProfile(
    GetSavedProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    try {
      String url = "$getSavedProfileUrl${event.userId}";
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${await TokenService.getToken()}"},
      );
      if (response.statusCode == 200) {
        var res = getSavedProfileModelFromJson(response.body);
        emit(GetSavedProfileState(getSavedProfileModel: res));
      } else {
        emit(ProfileErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProfileErrorState(errorMsg: e.toString()));
    }
  }

  onSaveProfie(SaveProfileApiEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    SaveProfileModel saveProfileModel = SaveProfileModel();
    saveProfileModel.name = event.name;
    saveProfileModel.email = event.emailAddress;
    saveProfileModel.mobileNumber = event.mobileNo;

    try {
      String url = profileSaveUrl;
      api.Response response = await api.ApiService().postRequest(
        url,
        saveProfileModelToJson(saveProfileModel),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var saveProfileResponse =
        //     addItemToCartResponseFromJson(response.resBody);
        emit(ProfileSaveSuccessState());
      } else {
        var errorrsp = saveProfileErrorResponseFromJson(response.resBody);
        if (errorrsp.error != null) {
          if (errorrsp.error!.contains("E11000")) {
            emit(UpdateProfileState());
          } else {
            var res = saveProfileErrorModelFromJson(response.resBody);
            emit(ProfileErrorState(errorMsg: res.message ?? "Error"));
          }
        } else {
          var res = saveProfileErrorModelFromJson(response.resBody);
          emit(ProfileErrorState(errorMsg: res.message ?? "Error"));
        }
      }
    } catch (e) {
      emit(ProfileErrorState(errorMsg: e.toString()));
    }
  }

  onUpdateProfie(
    UpdateProfileApiEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    SaveProfileModel saveProfileModel = SaveProfileModel();
    saveProfileModel.name = event.name;
    saveProfileModel.email = event.emailAddress;
    saveProfileModel.mobileNumber = event.mobileNo;

    try {
      String url = updateProfileUrl;
      api.Response response = await api.ApiService().postRequest(
        url,
        saveProfileModelToJson(saveProfileModel),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var saveProfileResponse =
        //     addItemToCartResponseFromJson(response.resBody);
        emit(ProfileSaveSuccessState());
      } else {
        var res = updateProfileModelFromJson(response.resBody);
        emit(ProfileErrorState(errorMsg: res.message ?? "Error"));
      }
    } catch (e) {
      emit(ProfileErrorState(errorMsg: e.toString()));
    }
  }
}
