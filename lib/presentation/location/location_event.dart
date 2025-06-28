abstract class LocationEvent {}

class GetLocationEvent extends LocationEvent {}

class SearchLocationEvent extends LocationEvent {
  final String searchText;

  SearchLocationEvent({required this.searchText});
}

class GetLatLonOnListEvent extends LocationEvent {
  final String placeId;

  GetLatLonOnListEvent({required this.placeId});
}

class GetLatLonEvent extends LocationEvent {
  final String latitude;
  final String longitude;

  GetLatLonEvent({required this.latitude, required this.longitude});
}

class GetLatLonOnIdleEvent extends LocationEvent {
  final String latitude;
  final String longitude;

  GetLatLonOnIdleEvent({required this.latitude, required this.longitude});
}

class LatLonLocationEvent extends LocationEvent {
  final String latitude;
  final String longitude;
  final String screenType;
  final String? place;

  LatLonLocationEvent(
      {required this.latitude,
      required this.longitude,
      required this.screenType,
      required this.place});
}

class ContinueLocationEvent extends LocationEvent {
  final String latitude;
  final String longitude;
  final String screenType;

  ContinueLocationEvent(
      {required this.latitude,
      required this.longitude,
      required this.screenType});
}
