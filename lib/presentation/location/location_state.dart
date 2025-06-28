import 'package:geocoding/geocoding.dart';
import 'package:sodakkuapp/model/addaddress/search_location_response_model.dart';

abstract class LocationState {}

class LocationInitialState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationSuccessState extends LocationState {
  String? latitude;
  String? longitude;
  Placemark? place;

  LocationSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}

class LatLongSuccessState extends LocationState {
  String latitude;
  String longitude;

  LatLongSuccessState({required this.latitude, required this.longitude});
}

class GetLatLonSuccessState extends LocationState {
  final String latitude;
  final String longitude;

  GetLatLonSuccessState({required this.latitude, required this.longitude});
}

class LocationContinueSuccessState extends LocationState {
  String screenType;
  String? latitude;
  String? longitude;
  String? place;
  Placemark placemark;

  LocationContinueSuccessState({
    required this.screenType,
    required this.latitude,
    required this.longitude,
    required this.place,
    required this.placemark,
  });
}

class SearchedLocationSuccessState extends LocationState {
  final List<SearchedLocationResponse> searchedLocationResponse;

  SearchedLocationSuccessState({required this.searchedLocationResponse});
}

class LocationErrorState extends LocationState {
  final String error;

  LocationErrorState({required this.error});
}
